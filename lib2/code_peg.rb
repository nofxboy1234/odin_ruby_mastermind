# frozen_string_literal: true

# The CodePeg class is responsible for the coloured pegs.
# They are represented with a number.
class CodePeg
  attr_reader :number, :id, :ids

  def initialize(number, index)
    @ids = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D' }

    @number = ColourNumber.new(number)
    @id = create_id(index)
  end

  def create_id(index)
    ids[index]
  end

  def valid?
    number.valid?
  end
end
