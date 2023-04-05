# frozen_string_literal: true

# The Board class is responsible for storing guess and clue pegs
class Board
  private

  attr_reader :clue

  public

  attr_reader :mastercode, :code_pegs, :clue_pegs

  def initialize
    @code_pegs = []
    init_pegs
  end

  def store_mastercode(code)
    @mastercode = code
  end

  def store_code_pegs(pegs)
    code_pegs << pegs
  end

  def store_clue_pegs(clue)
    @clue_pegs = clue
  end

  def show
    p mastercode
    p last_code_peg_row
    p clue_pegs
  end

  def u_pegs
    return [] if clue_pegs.nil?

    clue_pegs.no_match_pegs
  end

  def clear
    init_pegs
  end

  def current_row
    code_pegs.length
  end

  def last_code_peg_row
    code_pegs.last
  end

  def max_rows_reached?
    code_pegs.length == 13
  end

  def code_pegs_match_mastercode?
    clue_pegs.all_x?
  end

  private

  def init_pegs
    @mastercode = CodePegRow.new(nil)
    code_peg_row = CodePegRow.new(nil)
    code_pegs.clear
    store_code_pegs(code_peg_row)
  end
end

