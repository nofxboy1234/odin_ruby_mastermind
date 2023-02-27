class Computer < Player
  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    random_code.join
  end

  private

  def random_code
    (1..4).inject([]) { |random4, _n| random4 << rand(1..6) }
  end
end
