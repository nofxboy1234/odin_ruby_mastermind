# frozen_string_literal: true

# The CodePeg class is responsible for the coloured pegs.
# They are represented with a number.
class CodePeg
  attr_reader :colour, :id, :ids

  def initialize(number, index, min_number, max_number)
    @ids = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D' }

    @colour = RangeNumber.new(number, min_number, max_number)
    @id = create_id(index)
  end

  def valid?
    colour.valid?
  end

  def colour_number
    colour.number
  end

  def update_id(id)
    @id = id
  end

  private

  def create_id(index)
    ids[index]
  end
end
