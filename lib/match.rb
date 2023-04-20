# frozen_string_literal: true

# The Match class is responsible for a match type in a clue
class Match
  private

  attr_reader :number, :index, :clue_index_writable, :board

  public

  def initialize(number, index, clue_index_writable, board)
    @number = number
    @index = index
    @clue_index_writable = clue_index_writable
    @board = board
  end

  def decrement_tally
    board.secret_row.decrement_tally(number)
  end

  def type
    if exact_match?
      decrement_tally
      'x'
    elsif partial_match?
      decrement_tally
      'o'
    else
      '_'
    end
  end

  private

  def tally_count_positive?
    board.secret_row.tally_count_positive?(number)
  end

  def number_equals_secret_number?
    number == board.secret_numbers[index]
  end

  def exact_match?
    clue_index_writable &&
      tally_count_positive? &&
      number_equals_secret_number?
  end

  def partial_match?
    clue_index_writable &&
      tally_count_positive?
  end
end
