# frozen_string_literal: true

# The MatchChecker class is responsible for checking Matches
class MatchChecker
  private

  attr_reader :template, :board, :code_row

  public

  def initialize(template, board, code_row)
    @template = template
    @board = board
    @code_row = code_row
  end

  def check
    check_for_exact_matches
    check_for_partial_matches
  end

  private

  def check_for_exact_matches
    matches.each_with_index do |match, index|
      match.check_for_exact_match(template, index)
    end
  end

  def check_for_partial_matches
    matches.each_with_index do |match, index|
      match.check_for_partial_match(template, index)
    end
  end

  def matches
    @matches ||= code_row.numbers_with_index.map do |number, index|
      clue_index_writable = clue_index_writable?(index)
      Match.new(number, index, clue_index_writable, board)
    end
  end

  def clue_index_writable?(index)
    template[index] == '_'
  end
end
