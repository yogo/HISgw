class Method
  include DataMapper::Resource

  property :id, Serial, :required => true, :key => true, :field => "MethodID"
  property :method_description, String, :required => true, :field => "MethodDescription"
end