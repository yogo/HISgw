class QualityControlLevel
  include DataMapper::Resource

  property :id, Serial, :required => true, :key => true, :field => "QualityControlLevelID"
  property :quality_control_level_code, String, :required => true, :field => "QualityControlLevelCode"
  property :definition, String, :required => true, :field => "Definition"
  property :explanation, String, :required => true, :field => "Explanation"

  has n, :data_values, :model => "DataValue"

end