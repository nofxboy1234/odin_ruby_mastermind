# frozen_string_literal: true

# The ClueRow class is responsible for storing a clue in the game
class ClueRow
  attr_reader :pegs

  def initialize; end

  def to_s
    peg_numbers.to_s
  end

  def join
    peg_numbers.join
  end

  private

  def peg_numbers
    pegs.map(&:number).map(&:number)
  end
end
