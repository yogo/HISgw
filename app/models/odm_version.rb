class ODMVersion
  include DataMapper::Resource

  storage_names[:default] = 'ODMVersion'

  property :version_number, String, :required => true, :key =>true, :field => "VersionNumber"
end