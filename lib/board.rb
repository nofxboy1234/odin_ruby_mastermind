class Board
  attr_reader :mastercode, :guess_pegs

  def initialize
    init_pegs
  end

  def store_mastercode(code)
    @mastercode = code
  end

  def store_guess_pegs(pegs)
    @guess_pegs << pegs
  end

  def store_clue_pegs(clue)
    clue.each_with_index do |clue_value, index|
      @guess_pegs.last[index].clue = clue_value
    end
  end

  def show
    p mastercode.split('')
    # return unless guess_pegs

    p last_guess
  end

  def clear
    init_pegs
  end

  def current_row
    guess_pegs.length
  end

  def last_guess
    # return unless guess_pegs
    guess_pegs.last.map(&:value)
  end

  private

  def init_pegs
    @mastercode = nil
    peg_row = [GuessPeg.new('', '_'),
               GuessPeg.new('', '_'),
               GuessPeg.new('', '_'),
               GuessPeg.new('', '_')]
    @guess_pegs = []
    store_guess_pegs(peg_row)
  end
end
