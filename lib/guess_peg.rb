class GuessPeg
  attr_accessor :value, :clue, :original_index

  def initialize(value, clue = nil, original_index = nil)
    @value = value
    @clue = clue
    @original_index = original_index
  end
end
