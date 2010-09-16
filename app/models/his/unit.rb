class Unit
  include DataMapper::Resource

  storage_names[:default] = "Units"

  property :id,                 Serial, :required => true, :field => "UnitsID",         :key =>true
  property :units_name,         String, :required => true, :field => "UnitsName"
  property :units_type,         String, :required => true, :field => "UnitsType"
  property :units_abbreviation, String, :required => true, :field => "UnitsAbbreviation"

  has n, :variables, :model => "Variables"
  has n, :offset_types, :model => "OffsetTypes"

end