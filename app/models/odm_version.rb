class ODMVersion
  include DataMapper::Resource

  storage_names[:default] = 'odm_version'

  property :version_number, String, :required => true, :key =>true, :field => "VersionNumber"
end