class DerivedFrom
  include DataMapper::Resource

  property :derived_from_id,  Integer, :required => true, :key=>true, :field => "DerivedFromID"
  property :value_id,         Integer, :required => true, :field => "ValueID"

end
