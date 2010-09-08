class VerticalDatumCV
  include DataMapper::Resource

  property :term,       String, :field => "Term",       :required => true, :key => true
  property :Definition, String, :field => "Definition"

  has n, :sites, :model => "Site"

  validates_with_method :term, :method => :check_term

  def check_term
    check_ws_absence(self.term, "Term")
  end
end