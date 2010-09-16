class Group
  include DataMapper::Resource

  property :id,       Integer, :required => true, :field => "GroupID", :key => true
  property :value_id, Integer, :required => true, :field => "ValueID"

  belongs_to :group_descriptions, :model => "GroupDescription", :child_key => [:group_id]
  belongs_to :data_values,        :model => "DataValue",        :child_key => [:value_id]
end