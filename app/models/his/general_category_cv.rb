class GeneralCategoryCV
  include DataMapper::Resource
  storage_names[:default] = "GeneralCategoryCV"
  
  property :term,       String, :required => true, :key => true, :field => "Term"
  property :definition, String, :field => "Definition"

  has n, :variables, :model => "Variable"
end