# frozen_string_literal: true

# The ClueRow class is responsible for storing a row of CluePegs
class ClueRow
  private

  attr_reader :numbers_with_index, :board, :template, :secret_row_tally
  
  public

  attr_reader :pegs

  def initialize(code_row, board)
    @numbers_with_index = code_row.numbers_with_index
    @board = board
    @secret_row_tally = board.secret_row_numbers.tally
    @template = %w[_ _ _ _]

    create_pegs
  end

  def to_s
    pegs.map(&:clue).to_s
  end

  # def join; end

  def all_matches?
    pegs.all?(&:match?)
  end

  def any_partials?
    pegs.any?(&:partial?)
  end

  def all_empty?
    pegs.all?(&:empty?)
  end

  def format
    pegs.delete_if { |peg| peg.clue == '_' }
    pegs.sort { |peg, _next_element| peg.clue == 'x' ? -1 : 1 }
  end

  def empty_clue_pegs_indices
    pegs.each_with_index.filter_map do |clue_peg, index|
      index if clue_peg.empty?
    end
  end

  private

  def clue_index_writable?(index)
    template[index] == '_' || template[index] == 'o'
  end

  def matches_remaining?(number)
    # binding.pry
    secret_row_tally.keys.any?(number) &&
      secret_row_tally[number].positive?
  end

  def exact_match?(number, index)
    clue_index_writable?(index) &&
      matches_remaining?(number) &&
      number == board.secret_row_numbers[index]
  end

  def partial_match?(number, index)
    board.secret_numbers_with_index.any? do |secret_number, secret_index|
      clue_index_writable?(index) &&
        matches_remaining?(number) &&
        index != secret_index &&
        number == secret_number
    end
  end

  def check_for_exact_matches
    numbers_with_index.each do |number, index|
      if exact_match?(number, index)
        secret_row_tally[number] -= 1
        template[index] = 'x'
      end
    end
  end

  def check_for_partial_matches
    numbers_with_index.each do |number, index|
      if partial_match?(number, index)
        secret_row_tally[number] -= 1
        template[index] = 'o'
      end
    end
  end

  def clues
    # binding.pry
    check_for_exact_matches
    check_for_partial_matches
    template
  end

  def create_pegs
    @pegs = clues.map { |clue| CluePeg.new(clue) }
  end
end
