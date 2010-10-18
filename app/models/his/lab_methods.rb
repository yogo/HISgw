class LabMethod
  include DataMapper::Resource
  storage_names[:default] = "LabMethods"

  property :id, Serial, :required => true, :key => true, :field => "LabMethodID"
  property :lab_name, String, :required => true, :default => 'Unknown', :field => "LabName"
  property :lab_organization, String, :required => true, :default => 'Unknown', :field => "LabOrganization"
  property :lab_method_name, String, :required => true, :default => 'Unknown', :field => "LabMethodName"
  property :lab_method_description, String, :required => true, :default => 'Unknown', :field => "LabMethodDescription"
  property :lab_method_link, String, :field => "LabMethodLink"

  has n, :samples, :model => "Sample"

end