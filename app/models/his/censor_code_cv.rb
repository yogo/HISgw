class CensorCodeCV
  include DataMapper::Resource

  property :term,       String, :required => true, :key => true, :field =>"Term"
  property :definition, String, :field => "Definition"

  has n,  :DataValues, :model => "DataValue"

end
