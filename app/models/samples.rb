class Sample
  include DataMapper::Resource

  property :id, Serial, :required => true, :key => true, :field => "SampleID"
  property :sample_type, String, :required => true, :default => 'Unknown', :field => "SampleType"
  property :lab_sample_code, String, :required => true, :field => "LabSampleCode"
  property :lab_method_id, Integer, :required => true, :default => 0, :field => "LabMethodID"

  has n, :data_values, :model => "DataValue"
  belongs_to :sample_type_cv, :model => "SampleTypeCV", :child_key => [:sample_type]
  belongs_to :lab_methods, :model => "LabMethod", :child_key => [:lab_method_id]

  validates_with_method :lab_simple_code, :method => :check_lab_sample_code
  def check_lab_sample_code
    check_ws_absence(self.lab_sample_code, "LabSampleCode")
  end
end