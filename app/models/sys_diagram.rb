class SysDiagrams
  include DataMapper::Resource

  property :name, String, :required => true, :unique => true, :field => "Name"
  property :principal_id, Integer, :required => true, :unique => true, :field => "Principal_id"
  property :diagram_id, Serial, :required => true, :key => true, :field => "DiagramID"
  property :version, Integer, :field => "Version"
  property :definition, Boolean, :field => "Definition" #VarBinary isn't support by DataMapper
end
