
class District

  attr_reader :name, :enrollment, :statewide_test

  def initialize(hash)
    @name = hash[:name].upcase
    @enrollment = hash[:enrollment]
    @statewide_test = hash[:statewide_test]
  end

end
