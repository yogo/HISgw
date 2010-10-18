class Qualifier
  include DataMapper::Resource
  storage_names[:default] = "Qualifiers"

  property :id, Serial, :required => true, :key => true, :field => "QualifierID"
  property :qualifier_code, String, :field => "QualifierCode"
  property :qualifier_description, String, :required => true, :field => "QualifierDescription"

  has n, :data_values, :model => "DataValue"
end