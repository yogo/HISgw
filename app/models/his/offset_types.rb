class OffsetType
  include DataMapper::Resource
  storage_names[:default] = "OffsetType"

  property :id, Serial, :required => true, :key => true, :field => "OffsetTypeID"
  property :offset_units_id, Integer, :required => true, :field => "OffsetUnitsID"
  property :offset_description, String, :required => true, :field => "OffsetDescription"

  has n, :data_values, :model => "DataValue"
  belongs_to :Units, :model => "Unit", :child_key => [:offset_units_id]
end