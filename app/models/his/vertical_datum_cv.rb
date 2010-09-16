class VerticalDatumCV
  include DataMapper::Resource

  property :term,       String, :field => "Term",       :required => true, :key => true
  property :Definition, String, :field => "Definition"

  has n, :sites, :model => "Site"
end