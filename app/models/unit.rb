class Unit
  include DataMapper::Resource

  property :id,                 Serial, :required => true, :field => "UnitsID",         :key =>true
  property :units_name,         String, :required => true, :field => "UnitsName"
  property :units_type,         String, :required => true, :field => "UnitsType"
  property :units_abbreviation, String, :required => true, :field => "UnitsAbbreviation"

  has n, :variables, :model => "Variables"
  has n, :offset_types, :model => "OffsetTypes"

  validates_with_method :units_name, :method => :check_units_name
  def check_units_name
    check_ws_absence(self.units_name, "UnitsName")
  end

  validates_with_method :units_type, :method => :check_units_type
  def check_units_type
    check_ws_absence(self.units_type, "UnitsType")
  end

  validates_with_method :units_abbreviation, :method => :check_units_abbreviation
  def check_units_abbreviation
    check_ws_absence(self.units_abbreviation, "UnitsAbbreviation")
  end
end