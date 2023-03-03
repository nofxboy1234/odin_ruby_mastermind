class GuessPeg
  attr_reader :value, :clue, :index

  def initialize(value, clue, index)
    @value = value
    @clue = clue
    @index = index
  end
end
