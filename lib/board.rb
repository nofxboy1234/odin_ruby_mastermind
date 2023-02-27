class Board
  attr_reader :guess_pegs, :mastercode_pegs

  def initialize
    init_pegs
  end

  def store_guess_pegs(pegs)
    guess_pegs << pegs
  end

  def store_mastercode_pegs(pegs)
    @mastercode_pegs = pegs
  end

  def show
    p mastercode_pegs.split('')
    p guess_pegs.last.split('')
  end

  def clear
    init_pegs
  end

  def current_row
    guess_pegs.length + 1
  end

  private

  def init_pegs
    @mastercode_pegs = nil
    @guess_pegs = []
  end
end
