class Sources
  include DataMapper::Resource

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


  validates_with_method :organization, :check_organization
  def check_organization
    check_ws_absence(self.organization, "Organization")
  end

  validates_with_method :contact_name, :method => :check_contact_name
  def check_contact_name
    check_ws_absence(self.contact_name, "ContactName")
  end

  validates_with_method :phone, :method => :check_phone
  def check_phone
    check_ws_absence(self.phone, "Phone")
  end

  validates_with_method :email, :method => :check_email
  def check_email
    check_ws_absence(self.email, "Email")
  end

  validates_with_method :address, :method => :check_address
  def check_address
    check_ws_absence(self.address, "Address")
  end

  validates_with_method :city, :method => :check_city
  def check_city
    check_ws_absence(self.city, "City")
  end

  validates_with_method :state, :method => :check_state
  def check_state
    check_ws_absence(self.state, "State")
  end

  validates_with_method :zip_code, :method => :check_zip_code
  def check_zip_code
    check_ws_absence(self.zip_code, "Zipcode")
  end
end