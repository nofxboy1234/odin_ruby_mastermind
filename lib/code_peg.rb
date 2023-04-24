# frozen_string_literal: true

# The CodePeg class is responsible for the coloured pegs.
# They are represented with a number.
class CodePeg
  attr_reader :colour, :id, :ids, :clue_peg

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

  def store_clue_peg(clue_peg)
    @clue_peg = clue_peg
  end

  def update_with_random_number(board, index, last_guess_pegs, last_clue_pegs)
    colour.update(valid_random_numbers(board, index, last_guess_pegs, last_clue_pegs).sample)
    mark_empty_clue_peg_as_updated
  end

  private

  def mark_empty_clue_peg_as_updated
    @id = "#{id}*"
  end

  def valid_random_numbers(board, index, last_guess_pegs, last_clue_pegs)
    ('1'..'6').reject do |number|
      board.all_empty_code_peg_numbers.include?(number) ||
        (number == last_guess_pegs[index].colour_number && last_clue_pegs[index].partial?)
    end
  end

  def create_id(index)
    ids[index]
  end
end
