class SampleMediumCV
  include DataMapper::Resource
  storage_names[:default] = "SampleMediumCV"

  property :term, String, :required => true, :key => true, :field => "Term"
  property :definition, String, :field => "Definition"

  has n, :samples, :model => "Sample"
end