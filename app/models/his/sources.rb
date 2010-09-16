class Source
  include DataMapper::Resource

  storage_names[:default] = "Sources"

  property :id, Serial, :required => true, :key => true, :field => "SourceId" #should be SourceID but id is required by datamapper or persever-adapter
  property :organization, String, :required => true, :field => "Organization"
  property :source_description, String, :required => true, :field => "SourceDescription"
  property :source_link, String, :field => "SourceLink"
  property :contact_name, String, :required => true, :default => "Unkown", :field => "ContactName"
  property :phone, String, :required => true, :default => "Unkown", :field => "Phone"
  property :email, String, :required => true, :default => "Unkown", :field => "Email"
  property :address, String, :required => true, :default => "Unkown", :field => "Address"
  property :city, String, :required => true, :default => "Unkown", :field => "City"
  property :state, String, :required => true, :default => "Unkown", :field => "State"
  property :zip_code, String, :required => true, :default => "Unkown", :field => "ZipCode"
  property :citation, String, :required => true, :default => "Unkown", :field => "Citation"
  property :metadata_id, Integer, :required => true, :default => 0, :field => "MetadataID"

  has n, :data_values, :model => "DataValue"
  belongs_to :iso_metadata, :model => "ISOMetadata", :child_key => [:id]

end