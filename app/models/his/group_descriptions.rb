class GroupDescription
  include DataMapper::Resource
  storage_names[:default] = "GroupDescriptions"

  property :id,                 Serial, :required => true, :key => true, :field => "GroupID"
  property :group_description,  String, :field => "GroupDescription"

  has n, :groups, :model => "Group"
end