# frozen_string_literal: true

# The Board class is responsible for storing guess and clue pegs
class Board
  attr_reader :mastercode, :guess_pegs

  def initialize
    @guess_pegs = []
    init_pegs
  end

  def store_mastercode(code)
    @mastercode = code
  end

  def store_guess_pegs(pegs)
    guess_pegs << pegs
  end

  def store_clue_pegs(clue)
    clue.each_with_index do |clue_value, index|
      guess_pegs.last[index].clue = clue_value
    end
  end

  def show
    p mastercode.split('')
    p last_guess
  end

  def clear
    init_pegs
  end

  def current_row
    guess_pegs.length
  end

  def last_guess
    guess_pegs.last.map(&:value)
  end

  def max_rows_reached?
    guess_pegs.length == 13
  end

  private

  def init_pegs
    @mastercode = nil
    peg_row = [GuessPeg.new('', '_'),
               GuessPeg.new('', '_'),
               GuessPeg.new('', '_'),
               GuessPeg.new('', '_')]
    guess_pegs.clear
    store_guess_pegs(peg_row)
  end
end
