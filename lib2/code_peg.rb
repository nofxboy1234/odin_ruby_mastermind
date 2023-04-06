# frozen_string_literal: true

# The CodePeg class is responsible for the coloured pegs.
# They are represented with a number.
class CodePeg
  attr_reader :number, :id, :ids

  def initialize(number, index, min_number, max_number)
    @ids = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D' }

    @number = RangeNumber.new(number, min_number, max_number)
    @id = create_id(index)
  end

  def valid?
    number.valid?
  end

  private

  def create_id(index)
    ids[index]
  end
end
