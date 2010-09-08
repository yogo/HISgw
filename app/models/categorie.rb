class Categorie
  include DataMapper::Resource

  property :id,                   Integer,  :required => true, :field => "VariableID",  :key => true
  property :data_value,           Float,    :required => true, :field => "DataValue"
  property :category_description, String,   :required => true, :field => "CategoryDescription"

  has n,      :data_values, :model => "DataValue"
  belongs_to  :variables,   :model => "Variable", :child_key => [:id]
end
