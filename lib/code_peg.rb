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

  def update_with_random_number(board)
    colour.update(valid_random_numbers(board).sample)
    mark_empty_clue_peg_as_updated
  end

  private

  def mark_empty_clue_peg_as_updated
    @id = "#{id}*"
  end

  def valid_random_numbers(board)
    ('1'..'6').reject do |number|
      board.all_empty_code_peg_numbers.include?(number)
    end
  end

  def create_id(index)
    ids[index]
  end
end
