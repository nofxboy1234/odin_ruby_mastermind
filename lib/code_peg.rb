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

  def update_with_random_number(restriction)
    colour.update(valid_random_numbers(restriction).sample)
    mark_empty_clue_peg_as_updated
  end

  private

  def mark_empty_clue_peg_as_updated
    @id = "#{id}*"
  end

  def valid_random_numbers(restriction)
    ('1'..'6').reject do |number|
      restriction.existing_empty_peg_number?(number) ||
        restriction.partial_with_same_index_and_number?(number)
    end
  end

  def create_id(index)
    ids[index]
  end
end
