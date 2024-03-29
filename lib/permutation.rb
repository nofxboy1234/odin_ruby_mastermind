# frozen_string_literal: true

# The Permutation class is responsible for storing permutations used
# while guessing in MasterMind.
class Permutation
  private

  attr_reader :board, :guess_pegs, :last_guess_pegs, :current_permutation

  public

  def initialize(board, guess_pegs, last_guess_pegs)
    @board = board
    @guess_pegs = guess_pegs
    @last_guess_pegs = last_guess_pegs
  end

  def sample
    clue_row = board.clue_rows.last

    if clue_row.only_partials?
      partial_permutations.sample
    elsif clue_row.partials_and_matches?
      partial_match_permutations.sample
    else
      guess_pegs
    end
  end

  def match_pegs_with_index
    guess_pegs.each_with_index.select do |_guess_peg, index|
      board.clue_rows.last.pegs[index].match?
    end
  end

  def all_match_pegs_valid?
    match_pegs_with_index.all? do |x_peg, original_index|
      permutation_index = current_permutation.index(x_peg)

      original_index == permutation_index &&
        x_peg.colour_number == current_permutation[permutation_index].colour_number
    end
  end

  def partial_pegs_with_index
    guess_pegs.each_with_index.select do |_guess_peg, index|
      board.clue_rows.last.pegs[index].partial?
    end
  end

  def all_partial_pegs_valid?
    partial_pegs_with_index.all? do |o_peg, original_index|
      permutation_index = current_permutation.index(o_peg)

      if original_index != permutation_index &&
         numbers_equal?(o_peg, permutation_index)
        clue_peg = board.clue_rows.last.pegs[permutation_index]
        clue_peg.different_peg_number_in_last_pegs?(o_peg, permutation_index, last_guess_pegs)
      end
    end
  end

  def all_permutations
    guess_pegs.permutation(guess_pegs.size).to_a.uniq
  end

  def partial_permutations
    all_permutations.select do |permutation|
      @current_permutation = permutation
      all_partial_pegs_valid?
    end
  end

  def partial_match_permutations
    all_permutations.select do |permutation|
      @current_permutation = permutation
      all_partial_pegs_valid? && all_match_pegs_valid?
    end
  end

  private

  def numbers_equal?(o_peg, permutation_index)
    o_peg.colour_number == current_permutation[permutation_index].colour_number
  end
end
