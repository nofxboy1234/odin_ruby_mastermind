class Board
  attr_reader :mastercode, :guess_pegs

  def store_mastercode(code)
    @mastercode = code
  end

  def store_guess_pegs(pegs)
    @guess_pegs << pegs if @guess_pegs
  end

  def show
    p mastercode.split('')
    return unless guess_pegs

    p last_guess.split('')
  end

  def clear
    init_pegs
  end

  def current_row
    guess_pegs.length + 1
  end

  def last_guess
    # binding.pry
    return unless guess_pegs

    guess_pegs.last.map(&:value).join
  end

  private

  def init_pegs
    @mastercode = nil
    peg_row = (0..3).inject([]) do |array, index|
      array << GuessPeg.new(nil, nil, index)
    end
    store_guess_pegs(peg_row)
  end
end
