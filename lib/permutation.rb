# frozen_string_literal: true

# The Permutation class is responsible for storing permutations used
# while guessing in MasterMind.
class Permutation
  private

  attr_reader :board, :guess_pegs, :last_guess_pegs

  public

  def initialize(board, guess_pegs, last_guess_pegs)
    @board = board
    @guess_pegs = guess_pegs
    @last_guess_pegs = last_guess_pegs
  end

  def x_pegs_with_index
    guess_pegs.each_with_index.select do |_guess_peg, index|
      board.clue_rows.last.pegs[index].match?
    end
  end

  def all_x_pegs_valid?(permutation)
    x_pegs_with_index.all? do |x_peg, original_index|
      x_peg_valid?(x_peg, original_index, permutation)
    end
  end

  def o_pegs_with_index
    guess_pegs.each_with_index.select do |_guess_peg, index|
      board.clue_rows.last.pegs[index].partial?
    end
  end

  def all_o_pegs_valid?(permutation)
    o_pegs_with_index.all? do |o_peg, original_index|
      o_peg_valid?(o_peg, original_index, permutation)
    end
  end

  def all_permutations
    guess_pegs.permutation(guess_pegs.size).to_a.uniq
  end

  def valid_o_permutations
    all_permutations.select do |permutation|
      all_o_pegs_valid?(permutation)
    end
  end

  def valid_ox_permutations
    all_permutations.select do |permutation|
      all_o_pegs_valid?(permutation) && all_x_pegs_valid?(permutation)
    end
  end

  def x_peg_valid?(x_peg, original_index, permutation)
    permutation_index = permutation.index(x_peg)
    original_index == permutation_index &&
      x_peg.colour.number == permutation[permutation_index].colour.number
  end

  def different_peg_number?(permutation_index, o_peg)
    last_guess_pegs[permutation_index].colour.number != o_peg.colour.number
  end

  def different_peg_number_in_last_pegs?(o_peg, permutation_index)
    clue_peg = board.clue_rows.last.pegs[permutation_index]
    if clue_peg.partial?
      different_peg_number?(permutation_index, o_peg)
    elsif clue_peg.empty?
      true
    elsif clue_peg.match?
      false
    end
  end

  def o_peg_valid?(o_peg, original_index, permutation)
    permutation_index = permutation.index(o_peg)
    original_index != permutation_index &&
      o_peg.colour.number == permutation[permutation_index].colour.number &&
      different_peg_number_in_last_pegs?(o_peg, permutation_index)
  end
end
