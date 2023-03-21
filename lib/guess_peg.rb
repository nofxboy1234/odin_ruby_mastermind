class GuessPeg
  attr_accessor :value, :clue

  def initialize(value = '', clue = '_')
    @value = value
    @clue = clue
  end
end
