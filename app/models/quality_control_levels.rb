class QualityControlLevel
  include DataMapper::Resource

  property :id, Serial, :required => true, :key => true, :field => "QualityControlLevelID"
  property :quality_control_level_code, String, :required => true, :field => "QualityControlLevelCode"
  property :definition, String, :required => true, :field => "Definition"
  property :explanation, String, :required => true, :field => "Explanation"

  has n, :data_values, :model => "DataValue"

 validates_with_method :quality_control_level_code, :method => :check_quality_control_level_code
  def check_quality_control_level_code
    check_ws_absence(self.quality_control_level_code, "QualityControlLevelCode")
  end

  validates_with_method :definition, :method => :check_definition
  def check_definition
    check_ws_absence(self.definition, "Definition")
  end
end