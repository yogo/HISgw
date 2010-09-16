class DataValue
  include DataMapper::Resource

  storage_names[:default] = "DataValues"

  property :id,                       Serial,    :field => "ValueID",               :key => true
  property :data_value,               Float,     :field => "DataValue",             :required => true, :default => 0
  property :value_accuracy,           Float,     :field => "ValueAccuracy",                            :default => 1.0
  property :local_date_time,          DateTime,  :field => "LocalDateTime",         :required => true
  property :utc_offset,               Float,     :field => "UTCOffset",             :required => true, :default => 1.0
  property :date_time_utc,            DateTime,  :field => "DateTimeUTC",           :required => true, :default => "2009-12-01T02:00:00+00:00"##
  property :site_id,                  Integer,   :field => "SiteID",                :required => true, :default => 1
  property :variable_id,              Integer,   :field => "VariableID",            :required => true, :default => 1
  property :offset_value,             Float,     :field => "OffsetValue",                              :default => 1.0
  property :offset_type_id,           Integer,   :field => "OffsetTypeID",                             :default => 1
  property :censor_code,              String,    :field => "CensorCode",            :required => true, :default => 'nc'
  property :qualifier_id,             Integer,   :field => "QualifierID",                              :default => 4
  property :method_id,                Integer,   :field => "MethodID",              :required => true, :default => 0
  property :source_id,                Integer,   :field => "SourceID",              :required => true, :default => 1
  property :sample_id,                Integer,   :field => "SampleID",                                 :default => 1
  property :derived_from_id,          Integer,   :field => "DerivedFromID",                            :default => 1
  property :quality_control_level_id, Integer,   :field => "QualityControlLevelID", :required => true, :default => -9999
end
