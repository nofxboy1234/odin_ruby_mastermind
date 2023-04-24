# frozen_string_literal: true

# The EmptyPegRestriction class is responsible for restricting values of
# Code Pegs with empty clue pegs
class EmptyPegRestriction
  attr_reader :board, :index, :last_guess_pegs, :last_clue_pegs

  def initialize(board, index, last_guess_pegs, last_clue_pegs)
    @board = board
    @index = index
    @last_guess_pegs = last_guess_pegs
    @last_clue_pegs = last_clue_pegs
  end

  def existing_empty_peg_number?(number)
    board.all_empty_code_peg_numbers.include?(number)
  end

  def partial_with_same_index_and_number?(number)
    number == partial_with_same_number?(number) && partial_with_same_index?
  end

  private

  def partial_with_same_index?
    last_clue_pegs[index].partial?
  end

  def partial_with_same_number?(number)
    number == last_guess_pegs[index].colour_number
  end
end
