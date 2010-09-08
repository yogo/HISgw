class Variable
  include DataMapper::Resource

  property :id,               Serial, :required => true, :field => "VariableID",                :key => true
  property :variable_code,    String, :required => true, :field => "VariableCode"
  property :variable_name,    String, :required => true, :field => "VariableName"
  property :speciation,       String, :required => true, :field => "Speciation",      :default => 'Not Applicable'
  property :variable_units_id,Integer,:required => true, :field => "VariableUnitsID"
  property :sample_medium,    String, :required => true, :field => "SampleMedium",    :default => 'Unknown'
  property :value_type,       String, :required => true, :field => "ValueType",       :default =>'Unknown'
  property :is_regular,       Integer,:required => true, :field => "IsRegular",       :default => 0
  property :time_support,     Float,  :required => true, :field => "TimeSupport"
  property :time_units_id,    Integer,:required => true, :field => "TimeUnitsID",     :default => 103
  property :data_type,        String, :required => true, :field => "DataType",        :default => 'Unknown'
  property :general_category, String, :required => true, :field => "GeneralCategory", :default => 'Unknown'
  property :no_data_value,    Float,  :required => true, :field => "NoDataValue",     :default => -9999

  has n,     :Categories,           :model => "Categorie"
  belongs_to :units,                :model => "Unit",              :child_key => [:time_units_id, :variable_units_id] #will this work?
  belongs_to :data_type_cv,         :model => "DataTypeCV",        :child_key => [:data_type]
  belongs_to :general_category_cv,  :model => "GeneralCategoryCV", :child_key => [:general_category]
  belongs_to :sample_medium_cv,     :model => "SampleMediumCV",    :child_key => [:sample_medium]
  belongs_to :value_type_cv,        :model => "ValueTypeCV",       :child_key => [:value_type]
  belongs_to :variable_name_cv,     :model => "VariableNameCV",    :child_key => [:variable_name]
  belongs_to :speciation_cv,        :model => "SpeciationCV",      :child_key => [:speciation]
  belongs_to :data_values,          :model => "DataValue",         :child_key => [:varialbe_id]

  validates_uniqueness_of :variable_code

  validates_with_method :variable_code, :method => :check_variable_code
  def check_variable_code
    check_ws_absence(self.variable_code, "VariableCode")
  end
end