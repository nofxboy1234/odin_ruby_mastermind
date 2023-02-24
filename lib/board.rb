class Board
  attr_accessor :code_pegs
  attr_reader :guess_pegs

  def initialize
    @code_pegs = nil
    @guess_pegs = []
  end

  def store_guess_pegs(pegs)
    guess_pegs << pegs
  end

  def store_code_pegs(pegs)
    self.code_pegs = pegs
  end

  def show
    p code_pegs.split('')
    p guess_pegs.last.split('')
  end
end
