class LabMethod
  include DataMapper::Resource

  property :id, Serial, :required => true, :key => true, :field => "LabMethodID"
  property :lab_name, String, :required => true, :default => 'Unknown', :field => "LabName"
  property :lab_organization, String, :required => true, :default => 'Unknown', :field => "LabOrganization"
  property :lab_method_name, String, :required => true, :default => 'Unknown', :field => "LabMethodName"
  property :lab_method_description, String, :required => true, :default => 'Unknown', :field => "LabMethodDescription"
  property :lab_method_link, String, :field => "LabMethodLink"

  has n, :samples, :model => "Sample"

  validates_with_method :lab_name, :method => :check_lab_name
  def check_lab_name
    check_ws_absence(self.lab_name, "LabName")
  end

  validates_with_method :lab_organization, :method => :check_lab_organization
  def check_lab_organization
    check_ws_absence(self.lab_organization, "LabOrganization")
  end

  validates_with_method :lab_method_name, :method => :check_lab_method_name
  def check_lab_method_name
    check_ws_absence(self.lab_method_name, "LabMethodName")
  end
end