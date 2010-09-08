class SpatialReference
  include DataMapper::Resource

  property :id,             Serial,  :field => "SpatialReferenceID", :required => true, :key =>true
  property :srs_id,         Integer, :field => "SRSID"
  property :srs_name,       String,  :field => "SRSName",            :required => true
  property :is_geographic,  Integer, :field => "IsGeographic"
  property :notes,          String,  :field => "Notes"

  has n, :sites, :model => "Site"

  validates_with_method :srs_name, :method => :check_srs_name

  def check_srs_name
    check_ws_absence(self.srs_name, "SRSName")
  end
end