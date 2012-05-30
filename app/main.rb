# encoding: UTF-8

require 'iconv'
class HISGateway < Sinatra::Base
  set :views, File.dirname(__FILE__) + "/views"
#  set :root,  File.dirname(__FILE__) + "/.."
  set :tmp,   File.dirname(__FILE__) + "/../tmp/"
  set :sessions, true
  set :run, false
  set :haml, { :format => :html5 }

  configure(:development) do
    register Sinatra::Reloader
    also_reload "app/models/*.rb"
    dont_reload "lib/**/*.rb"
  end

  VALID_RESPONSE_FORMATS = [ :json, :xml, :csv, :yaml, :html ]
  
  before do
    set_response_type()
  end
  
  def post_format(model, data, format = nil)

    if data.nil?
      return make_xml_envelope(model)
    end

    if format == "xml"
      content_type :xml
      xml_doc = data.to_xml_document
      xml_doc << REXML::XMLDecl.new(1.0, "UTF-8")
      #xml_doc << REXML::XMLDecl.new(1.0, "UTF-8")
      xml_string = xml_doc.to_s
      char_detection = CharDet.detect(xml_string)
      xml_doc = Iconv.conv('UTF-8', char_detection['encoding'], xml_string)
      xml_doc = REXML::Document::new(xml_string)
      return xml_doc.to_s
    elsif format == "yaml"
      content_type :yaml
      return data.to_yaml
    elsif format == "csv"
      content_type :csv
      return data.to_csv
    elsif format == "json"
      content_type :json
      return data.to_json
    end

    types = Sinatra::Request.new(env).accept()
    if types.include?('application/json')
      content_type :json
      return data.to_json
    elsif types.include?('application/xml') || types.include?('text/xml')
      content_type :xml
      xml_doc = data.to_xml_document
      xml_doc << REXML::XMLDecl.new(1.0, "iso-8859-2")
      return xml_doc.to_s
    elsif types.include?('application/x-yaml') || types.include?('text/yaml')
      content_type :yaml
      return data.to_yaml
    elsif types.include?('text/csv') || types.include?('text/comma-separated-values')
      content_type :csv
      return data.to_csv
    else
      return data.to_json
    end
  end

  helpers do
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="HIS Gateway")
        throw(:halt, [401, "Not Authorized\n"])
      end
    end

    def authorized?
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
      return true
      # @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['voeis', 'secret']
    end
  end

  # stupid favicon.ico
  get %r{/favicon.*} do

  end

  # Main page, this is where documentation should go
  get '/' do
    haml :index
  end

  # Version of the API
  get '/version' do
    HISGW_VERSION
  end

  # ODM Version
  # 
  get %r{/odm_versions\.*(\w*)} do |format|

    respond_with( ::ODMVersion.all )
  end

  DataMapper::Model.descendants.each do |model|
    path = model.name.tableize

    get /\/#{path}(\/?$|\.\w+)/ do
      query_params = clean_query_params(model, params)
      data = model.all(query_params)
      respond_with( data )
    end

    get "/#{path}/:id/?" do
      id = params[:id].split('.')[0]
      respond_with( model.get( id ) )
    end

    put /\/#{path}\/:id(\/?$|\.\w+)/ do
      protected!
      request.body.rewind # in case someone already read it
      body = request.body.read
      xml.gsub!("his-#{model.name}", model.name)
      instance = model.get(params[:id])
      record = parse_resource(xml, model)
      instance.update(record)
      instance.save
      # Also set headers to say OKAY!
      respond_with(instance)
    end
  end

  post %r{/(\w*)\/*(\w*)\.*(\w*)} do |klass, id, format|
    protected!
    model_name = klass.singularize.camelize
    model = Object.const_get("#{model_name}")
    req = Rack::Request.new(env)
    xml = req.body.read
    xml.gsub!("his-#{model_name.downcase}", model_name)
    instance = model.create(parse_resource(xml, model))
    post_format(model, instance, format)
  end

  delete %r{/(\w*)\/*(\w*)\.*(\w*)} do |klass, id, format|
    protected!
    model = Object.const_get("#{klass.singularize.camelize}")
    instance = model.get(id)
    instance.destroy
  end

  private

  # When there is nothing to return you still have to return the right block
  def make_xml_envelope(model)
    xml  = DataMapper::Serialize::XMLSerializers::SERIALIZER
    doc  = xml.new_document
    root = xml.root_node(doc, model.to_s.underscore.tr("/", "-"))
    doc.to_s
    doc << XMLDecl.default
    doc.to_s
  end

  def record_from_rexml(entity_element, model)
    record = {}

    prop_lookup = model.properties.map { |p| [ p.name, p ] }.to_hash

    entity_element.elements.map do |element|
      # TODO: push this to the per-property mix-in for this adapter
      prop_name = element.name.to_s.tr('-', '_')
      next unless property = prop_lookup[prop_name.to_sym]
      record[prop_name] = property.typecast(element.text)
    end

    record
  end

  def parse_resource(xml, model)
    doc = REXML::Document::new(xml)

    element_name = model.storage_name.singularize

    unless entity_element = REXML::XPath.first(doc, "/#{element_name}")
      raise "No root element matching #{element_name} in xml"
    end

    record_from_rexml(entity_element, model)
  end

  def set_response_type
    types     = request.accept
    puts       request.path
    matches  = request.path.to_s.match(/\.(\w*)$/)
    extension = matches[1] unless matches.nil?
    
    @response_type = extension.to_sym if (!extension.nil?) && VALID_RESPONSE_FORMATS.include?(extension.to_sym)

    if @response_type.nil?
      if types.include?("text/html")
        @response_type = :html
      elsif types.include?('application/json')
        @response_type =  :json
      elsif types.include?('application/xml') || types.include?('text/xml')
        @response_type =  :xml
      elsif types.include?('application/x-yaml') || types.include?('text/yaml')
        @response_type = :yaml
      elsif types.include?('text/csv') || types.include?('text/comma-separated-values')
        @response_type = :csv
      else
        @response_type = :html
      end
    end
  end

  def respond_with(data)
    content_type @response_type

    if data.class == DataMapper::Collection
      ChunkedData.new(response, data, @response_type)
    else
      data_convert(data)
    end
  end

  def data_convert(data)
    case(@response_type)
    when :html then
      return data.to_xml
    when :json then
      return data.to_json
    when :yaml then
      return data.to_yaml
    when :csv  then
      return data.to_csv
    when :xml  then
      xml_doc = data.to_xml
      char_detection = CharDet.detect(xml_doc)
      xml_doc = Iconv.conv('UTF-8', char_detection['encoding'], xml_doc)
      return xml_doc
    else
      return data.to_s
    end
  end

  def clean_query_params(model, query_hash)
    valid_properties = model.properties.map(&:name)# +
    # [:limit, :offset] # limits and offsets are broken

    valid_params = {}
    query_hash.each_pair do |k,v|
      if valid_properties.include?(k.to_sym)
        v = v.to_i if [:limit, :offset].include?(k.to_sym)
        valid_params[k.to_sym] = v
      end

    end

    return valid_params
  end
  
end

# This isn't used right now, but might be useful so I'm leaving it here.
class MultipartBody
  def initialize(response, &block)
    @boundary = 'MultipartBody'
    response['Content-Type'] = "multipart/mixed; boundary=\"#{@boundary}\""
    response['Transfer-Encoding'] = 'chunked'
    instance_eval(&block) if block
  end
  
  def chunk(content_type, body)
    "--#{@boundary}\nContent-Type: #{content_type}\n\n#{body}\n"
  end
end

# Sends the data, chunked
class ChunkedData
  
  def initialize(response, content, content_type, &block)
    # Modify the response if needed.
    response["Content-Disposition"] = "attachment; filename=#{content.model.name}.#{content_type}"
    @content = content
    @content_type = content_type
  end
  
  def each
    yield preamble

     # Just get the first element into the stream
    yield convert_element( @content.first )
    
    offset = 1
    delta = 100
    done = false
    while( !done )
      chunk = @content[offset..(offset+delta)]
      yield  body( chunk ) unless chunk.count.eql?(0)
      offset += delta
      done = true if chunk.count < delta
    end
    
    yield postscript 
    
  end

  # Stuff that is needed before sending the main content
  def preamble
    case(@content_type)
    when :json then
      return "["
    when :xml then
      return REXML::XMLDecl.new(1.0, "UTF-8").to_s + "<#{@content.model.name.tableize} type='array'>"
    else
      return ""
    end
  end

  # Stuff to send after sending the main content
  def postscript
    case(@content_type)
    when :json then
      return "]"
    when :xml then
      return "</#{@content.model.name.tableize}>"
    else
      return ""
    end
  end

  # Convert element(s) into the content_type.
  def convert_element(data)
    unless data.nil?
      case(@content_type)
      when :json then
        return data.to_json
      when :xml,:html then
        return data.to_xml
      when :csv then
        return data.to_csv
      when :yaml then
        return data.to_yaml
      else
        return data.to_s
      end
    end
  end

  # Converts a subset of data into a chunk of the body
  def body(data)
    case(@content_type)
    when :json then
      return "," + data.collect{|d| d.to_json }.join(',')
    when :xml,:html then
      return data.collect{|d| d.to_xml }.join('')
    when :csv then
      return data.to_csv
    when :yaml then
      return data.to_yaml
    else
      return data.to_s
    end
  end
end

