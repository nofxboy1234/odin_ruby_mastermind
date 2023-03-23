class GuessPeg
  attr_accessor :value, :clue, :id

  def initialize(value = '', clue = '_')
    @value = value
    @clue = clue
    @id = nil
  end
end
