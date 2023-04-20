# frozen_string_literal: true

# The CluePeg class represents a clue peg used in the game
class CluePeg
  attr_reader :clue

  def initialize(clue)
    @clue = clue
  end

  def empty?
    clue == '_'
  end

  def partial?
    clue == 'o'
  end

  def match?
    clue == 'x'
  end

  def different_peg_number?(permutation_index, o_peg, last_guess_pegs)
    last_guess_pegs[permutation_index].colour_number != o_peg.colour_number
  end

  def different_peg_number_in_last_pegs?(o_peg, permutation_index, last_guess_pegs)
    if partial?
      different_peg_number?(permutation_index, o_peg, last_guess_pegs)
    elsif empty?
      true
    elsif match?
      false
    end
  end
end
