#
#
class HISGateway < Sinatra::Base
  set :views, File.dirname(__FILE__) + "/views"
  set :sessions, true
  set :run, false
  set :env, (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)
  set :haml, { :format => :html5 }

  def post_format(model, data, format = nil)

    if data.nil?
      return make_xml_envelope(model)
    end

    if format == "xml"
      content_type :xml
      xml_doc = data.to_xml_document
      xml_dox.to_s
      xml_doc << REXML::XMLDecl.default
      
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
      xml_doc.to_s
      xml_doc << REXML::XMLDecl.default
      
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
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['voeis', 'secret']
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
  get %r{/odm_versions\.*(\w*)} do |format|
    post_format(::ODMVersion, ::ODMVersion.all, format)
  end

  get %r{/(\w*)\/*(\w*)\.*(\w*)} do |klass, id, format|
    model = Object.const_get("#{klass.singularize.camelize.gsub("Cv", "CV")}")
    instance = id.empty? ? model.all : model.get(id.to_i)
    post_format(model, instance, format)
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

  put %r{/(\w*)\/*(\w*)\.*(\w*)} do |klass, id, format|
    protected!
    model_name = klass.singularize.camelize
    model = Object.const_get("#{model_name}")
    req = Rack::Request.new(env)
    xml = req.body.read
    xml.gsub!("his-#{model_name.underscore}", model_name)
    instance = model.get(id)
    record = parse_resource(xml, model)
    instance.update(parse_resource(xml, model))
    instance.save
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
end
