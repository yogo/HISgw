class ISOMetadata
  include DataMapper::Resource

  property :id,               Serial, :required => true, :key => true, :field => "MetadataID"
  property :topic_category,   String, :required => true, :default => 'Unknown', :field => "TopicCategory"
  property :title,            String, :required => true, :default => 'Unknown', :field => "Title"
  property :abstract,         String, :required => true, :default => 'Unknown', :field => "Abstract"
  property :profile_version,  String, :required => true, :default => 'Unknown', :field => "ProfileVersion"
  property :metadata_link,    String, :field => "MetadataLink"

  belongs_to  :topic_category_cv, :model => "TopicCategoryCV", :child_key => [:topic_category]
  has n,      :sources,           :model => "Source"

end