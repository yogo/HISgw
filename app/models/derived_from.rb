class DerivedFrom
  include DataMapper::Resource

  property :derived_from_id,  Integer, :required => true, :key=>true, :field => "DerivedFromID"
  property :value_id,         Integer, :required => true, :field => "ValueID"

  #belongs_to :DataValues, :class_name => "His::DataValues", :child_key => [:value_id]
  #has n, :DataValues, :class_name => "His::DataValues", :through => Resource #has and belongs to many
end