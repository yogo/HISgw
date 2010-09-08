class HISGateway < Sinatra::Base

  set :sessions, true
  set :views, File.join(File.dirname(__FILE__), 'views')
  set :run, false
  set :env, (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)
  set :haml, { :format => :html5 }

  def post_format(data)
    types = Sinatra::Request.new(env).accept()
    if types.include?('application/json')
      return data.to_json
    elsif types.include?('application/xml') || types.include?('text/xml')
      return data.to_xml
    elsif types.include?('application/x-yaml') || types.include?('text/yaml') || types.include?('text/x-yaml')
      return data.to_yaml
    elsif types.include?('text/csv') || types.include?('text/comma-separated-values')
      return data.to_csv
    else
      data.to_json
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
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['VOEIS', 'v0e!5']
    end
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
  get '/odm_version' do
    ::ODMVersion.first.version_number
  end

  # Sites
  get '/sites/?:id?' do
    if params.has_key?(:id)
      data = ::Site.get(params[:id])
    else
      data = ::Site.all
    end

    post_format(data)
  end

  post '/sites/' do
    protected!
  end

  put '/sites/?:id?' do
    protected!
  end

  delete '/sites/?:id?' do
    protected!
  end

  # Variables
  get '/variables/?:id?' do
    if params.has_key?(:id)
      data = ::Variable.get(params[:id])
    else
      data = ::Variable.all
    end
    post_format(data)
  end

  post '/variables/' do
    protected!
  end

  put '/variables/?:id?' do
    protected!
  end

  delete '/variables/?:id?' do
    protected!
  end

  # Units
  get '/units/?:id?' do
    if params.has_key?(:id)
      data = ::Unit.get(params[:id])
    else
      data = ::Unit.all
    end
    post_format(data)
  end

  post '/units/' do
    protected!
  end

  put '/units/?:id?' do
    protected!
  end

  delete '/units/?:id?' do
    protected!
  end
end
