class TopicCategoryCV
  include DataMapper::Resource
  storage_names[:default] = "TopicCategoryCV"

  property :term, String, :required => true, :key => true, :field => "Term"
  property :definition, String, :field => "Definition"

  has n, :iso_metadata, :model => "ISOMetadata"

end