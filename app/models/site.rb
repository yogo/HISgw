class Site
  include DataMapper::Resource

  property :id,                  Serial,  :field => "SiteID",            :required => true, :key => true
  property :site_code,           String,  :field => "SiteCode",          :required => true
  property :site_name,           String,  :field => "SiteName",          :required => true
  property :latitude,            Float,   :field => "Latitude",          :required => true
  property :longitude,           Float,   :field => "Longitude",         :required => true
  property :lat_long_datum_id,   Integer, :field => "LatLongDatumID",    :required => true, :default => 0
  property :elevation_m,         Float,   :field => "Elevation_m",       :required => false
  property :vertical_datum,      String,  :field => "VerticalDatum",     :required => false
  property :local_x,             Float,   :field => "LocalX",            :required => false
  property :local_y,             Float,   :field => "LocalY",            :required => false
  property :local_projection_id, Integer, :field => "LocalProjectionID", :required => false
  property :pos_accuracy_m,      Float,   :field => "PosAccuracy_m",     :required => false
  property :state,               String,  :field => "State",             :required => true
  property :county,              String,  :field => "County",            :required => false
  property :comments,            String,  :field => "Comments",          :required => false

  has n,     :data_values,        :model => "DataValue"
  belongs_to :vertical_datum_cv,  :model => "VerticalDatumCV",   :child_key => [:vertical_datum]
  belongs_to :spatial_references, :model => "SpatialReference", :child_key => [:lat_long_datum_id, :local_projection_id] #is this going to work?

  validates_uniqueness_of :site_code
end

