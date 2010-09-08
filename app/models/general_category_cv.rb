class GeneralCategoryCV
  include DataMapper::Resource

  property :term,       String, :required => true, :key => true, :field => "Term"
  property :definition, String, :field => "Definition"

  has n, :variables, :model => "Variable"

  #validates_with_block :check_ws_absence(self.Term, "Term")
  validates_with_method :term, :method => :check_term
  def check_term
    check_ws_absence(self.term, "Term")
  end
end