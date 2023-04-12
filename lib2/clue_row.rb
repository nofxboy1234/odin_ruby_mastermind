# frozen_string_literal: true

# The ClueRow class is responsible for storing a row of CluePegs
class ClueRow
  attr_reader :pegs, :clues

  def initialize(clues)
    @clues = clues

    create_pegs
  end

  def create_pegs
    @pegs = clues.map { |clue| CluePeg.new(clue) }
  end

  def to_s
    pegs.map(&:clue).to_s
  end

  # def join; end

  def all_empty?
    pegs.all?(&:empty?)
  end

  def any_partials?
    pegs.any?(&:partial?)
  end

  def all_matches?
    pegs.all?(&:match?)
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
end
