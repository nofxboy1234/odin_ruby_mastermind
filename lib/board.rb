# frozen_string_literal: true

# The Board class is responsible for storing guess and clue pegs
class Board
  private

  attr_reader :clue

  public

  attr_reader :mastercode, :guess_pegs

  def initialize
    @guess_pegs = []
    init_pegs
  end

  def store_mastercode(code)
    @mastercode = code
  end

  def store_guess_pegs(pegs)
    guess_pegs << pegs
    store_clue
    store_clue_pegs
  end

  def show
    p mastercode.split('')
    p last_guess
    p clue
  end

  def clear
    init_pegs
  end

  def current_row
    guess_pegs.length
  end

  def last_guess
    guess_pegs.last.map(&:value)
  end

  def max_rows_reached?
    guess_pegs.length == 13
  end

  private

  def calculate_clue(guess_peg_value, mastercode_tallies, index)
    if guess_peg_value == mastercode.split('')[index]
      clue[index] = 'x'
      mastercode_tallies[guess_peg_value] -= 1
    end

    return unless clue[index] == '_'

    clue[index] = 'o'
    mastercode_tallies[guess_peg_value] -= 1
  end

  def any_guess_peg_matches_left?(guess_peg_value, mastercode_tallies)
    mastercode_tallies.any? do |mastercode_peg_value, count|
      pegs_equal = guess_peg_value == mastercode_peg_value
      count_positive = count.positive?
      pegs_equal && count_positive
    end
  end

  def store_clue
    last_guess_pegs = guess_pegs.last
    mastercode_tallies = mastercode.split('').tally

    @clue = %w[_ _ _ _]

    last_guess_pegs.map(&:value).each_with_index do |guess_peg_value, index|
      next unless any_guess_peg_matches_left?(guess_peg_value, mastercode_tallies)

      calculate_clue(guess_peg_value, mastercode_tallies, index)
    end
  end

  def store_clue_pegs
    clue.each_with_index do |clue_value, index|
      guess_pegs.last[index].clue = clue_value
    end
  end

  def init_pegs
    @mastercode = '0000'
    peg_row = [CodePeg.new('', '_'),
               CodePeg.new('', '_'),
               CodePeg.new('', '_'),
               CodePeg.new('', '_')]
    guess_pegs.clear
    store_guess_pegs(peg_row)
  end
end
