class SeriesCatalog
  include DataMapper::Resource
  property :SeriesID, Serial, :required => true, :key => true
  property :SiteID, Integer
  property :SiteCode, String
  property :SiteName, String
  property :VariableID, Integer
  property :VariableCode, String
  property :VariableName, String
  property :Speciation, String
  property :VariableUnitsID, Integer
  property :VariableUnitsName, String
  property :SampleMedium, String
  property :ValueType, String
  property :TimeSupport, Float
  property :TimeUnitsID, Integer
  property :TimeUnitsName, String
  property :DataType, String
  property :GeneralCategory, String
  property :MethodID, Integer
  property :MethodDescription, String
  property :SourceID, Integer
  property :Organization, String
  property :SourceDescription, String
  property :Citation, String
  property :QualityControlLevelID, Integer
  property :QualityControlLevelCode, String
  property :BeginDateTime, DateTime
  property :EndDateTime, DateTime
  property :BeginDateTimeUTC, DateTime
  property :EndDateTimeUTC, DateTime
  property :ValueCount, Integer
end