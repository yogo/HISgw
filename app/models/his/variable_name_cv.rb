class VariableNameCV
  include DataMapper::Resource
  storage_names[:default] = "VariableNameCV"

  property :term, String, :required => true, :key => true, :field => "Term"
  property :definition, String, :field => "Definition"

  has n, :variables, :model => "Variable"

  def definition
    if self.term.eql?("9cis-Neoxanthin")
      return "9 cis-Neoxanthin - phytoplankton pigment"
    else
      return super
    end
  end

  def term
    tm = super
    if tm.eql?("9 cis-Neoxanthin")
      return "9cis-Neoxanthin"
    else
      return tm
    end
  end

  
end
