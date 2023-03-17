class GuessPeg
  attr_accessor :value, :clue
  attr_reader :original_index

  def initialize(value = '', clue = '_', original_index = nil)
    @value = value
    @clue = clue
    @original_index = original_index
  end
end
