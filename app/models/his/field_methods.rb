class FieldMethod
  include DataMapper::Resource
  storage_names[:default] = "Methods"

  property :id, Serial, :required => true, :key => true, :field => "MethodID"
  property :method_description, String, :required => true, :field => "MethodDescription"
  property :method_link, String, :required => false, :field => "MethodLink"
  
  belongs_to :data_values,          :model => "DataValue",         :child_key => [:method_id]
  
end