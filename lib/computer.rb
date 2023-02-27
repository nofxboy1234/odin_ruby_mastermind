class Computer < Player
  def create_mastercode
    board.store_mastercode_pegs(random_code.join)
  end

  def guess_mastercode
    random_code.join
  end

  private

  def random_code
    (1..4).inject([]) { |random4, _n| random4 << rand(1..6) }
  end
end
