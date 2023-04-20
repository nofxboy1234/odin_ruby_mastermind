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
    sorted_pegs = non_empty_pegs.sort do |peg, _next_element|
      peg.match? ? -1 : 1
    end
    sorted_pegs.map(&:clue)
  end

  def clue_index_writable?(index)
    template[index] == '_'
  end

  # def exact_match?(number, index)
  #   clue_index_writable?(index) &&
  #     board.secret_row.tally_count_positive?(number) &&
  #     number == board.secret_numbers[index]
  # end

  # def partial_match?(number, index)
  #   clue_index_writable?(index) &&
  #     board.secret_row.tally_count_positive?(number)
  # end

  def check_for_matches
    code_row.numbers_with_index.each do |number, index|
      clue_index_writable = clue_index_writable?(index)
      match = Match.new(number, index, clue_index_writable, board)

      template[index] = match.type
    end
  end

  # def check_for_exact_matches
  #   code_row.numbers_with_index.each do |number, index|
  #     if exact_match?(number, index)
  #       board.secret_row.decrement_tally(number)
  #       template[index] = 'x'
  #     end
  #   end
  # end

  # def check_for_partial_matches
  #   code_row.numbers_with_index.each do |number, index|
  #     if partial_match?(number, index)
  #       board.secret_row.decrement_tally(number)
  #       template[index] = 'o'
  #     end
  #   end
  # end

  def clues
    check_for_matches
    template
  end

  def create_pegs
    @pegs = clues.map { |clue| CluePeg.new(clue) }
  end
end
