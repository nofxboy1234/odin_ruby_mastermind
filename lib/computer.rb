class Computer < Player
  attr_reader :clue, :guess

  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    @guess = if clue
               #  random_code.join
               Guess.new(retain_x_strategy, clue)
             else
               Guess.new(random_code)
             end
    guess.join
  end

  def store_clue(clue)
    @clue = clue
  end
end
