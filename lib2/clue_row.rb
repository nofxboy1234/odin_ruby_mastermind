# frozen_string_literal: true

# The ClueRow class is responsible for storing a row of CluePegs
class ClueRow
  attr_reader :pegs

  def initialize(clues)
    @pegs = clues

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
    pegs.delete('_')
    pegs.sort { |peg, _next_element| peg.clue == 'x' ? -1 : 1 }
  end
end
