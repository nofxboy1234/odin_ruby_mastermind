class Board
  attr_reader :mastercode, :guess_pegs

  def initialize
    init_pegs
  end

  def store_mastercode(code)
    @mastercode = code
  end

  def store_guess_pegs(pegs)
    guess_pegs << pegs
  end

  def store_clue_pegs(pegs)
    clue_pegs << pegs
  end

  def show
    p mastercode.split('')
    p guess_pegs.last.split('')
  end

  def clear
    init_pegs
  end

  def current_row
    guess_pegs.length + 1
  end

  def last_guess
    guess_pegs.last
  end

  private

  def init_pegs
    @mastercode = nil
    peg_row = (0..3).inject([]) do |array, index|
      array << GuessPeg.new(nil, nil, index)
    end
    @guess_pegs << peg_row
  end
end
