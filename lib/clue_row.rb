# frozen_string_literal: true

# The ClueRow class is responsible for storing a row of CluePegs
class ClueRow
  private

  attr_reader :board, :template

  public

  attr_reader :pegs, :code_row

  def initialize(code_row, board)
    @code_row = code_row
    @board = board

    @template = %w[_ _ _ _]

    create_pegs
  end

  def to_s
    pegs.map(&:clue).to_s

    # format.to_s
  end

  def any_partials?
    pegs.any?(&:partial?)
  end

  def no_matches?
    pegs.none?(&:match?)
  end

  def only_partials?
    any_partials? && no_matches?
  end

  def partials_and_matches?
    any_partials? && any_matches?
  end

  def any_matches?
    pegs.any?(&:match?)
  end

  def empty_clue_pegs_indices
    pegs.each_with_index.filter_map do |clue_peg, index|
      index if clue_peg.empty?
    end
  end

  private

  def non_empty_pegs
    pegs.reject(&:empty?)
  end

  def format
    sorted_pegs = non_empty_pegs.sort_by { |element| -element.clue.ord }
    sorted_pegs.map(&:clue)
  end

  def clues
    match_checker = MatchChecker.new(template, board, code_row)
    match_checker.check
    template
  end

  def create_pegs
    @pegs = clues.map { |clue| CluePeg.new(clue) }
  end
end
