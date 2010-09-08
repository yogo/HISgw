class CensorCodeCV
  include DataMapper::Resource

  property :term,       String, :required => true, :key => true, :field =>"Term"
  property :definition, String, :field => "Definition"

  has n,  :DataValues, :model => "DataValue"

  validates_with_method :term, :method => :check_term
  def check_term
    check_ws_absence(self.term, "Term")
  end
end