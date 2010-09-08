class Method
  include DataMapper::Resource

  property :id, Serial, :required => true, :key => true, :field => "MethodID"
  property :method_description, String, :required => true, :field => "MethodDescription"
  #property :method_link, String, :field => "MethodLink",:required => false

  #has n,  :data_values, :class_name => "His::DataValues"
end