# frozen_string_literal: true

# The Computer class is responsible for guessing and choosing a mastercode
class Computer < Player
  def initialize(board)
    super
    @all_valid_clue_permutations = CluePermutation.all_valid_clue_permutations
    @count = @all_valid_clue_permutations.size
  end

  def choose_mastercode
    random_code.join
  end

  def random_code
    (1..4).inject([]) { |random_numbers, _n| random_numbers << rand(1..6) }
  end

  def rotate_and_decrement
    @all_valid_clue_permutations.rotate!
    @count -= 1
  end

  def test_all_clues
    if @count.positive?
      rotate_and_decrement
      Guess.new(test_guess_peg_row).guess_pegs
    else
      Guess.new(CluePermutation.all_x).guess_pegs
    end
  end

  def guess_mastercode
    # Guess.u_values_for_all_guesses.clear
    # Guess.new(CluePermutaion.test_specific_clue).guess_pegs

    # Guess.u_values_for_all_guesses.clear
    # test_all_clues

    Guess.new(board.guess_pegs.last).code_pegs
  end

  def test_guess_peg_row
    peg_row = []
    @all_valid_clue_permutations.first.each_with_index do |clue, index|
      guess_peg = CodePeg.new(index.succ.to_s, clue)
      peg_row << guess_peg
    end
    peg_row
  end
end
