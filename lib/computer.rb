class Computer < Player
  attr_reader :clue, :guess

  def initialize
    super
    @clue = nil
    @guess = nil
  end

  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    @guess = if clue.nil?
               Guess.new(random_code)
             else
               #  random_code.join
               Guess.new(retain_x_strategy)
             end
    guess.join
  end

  def store_clue(clue)
    @clue = clue
  end

  private

  def retain_x_strategy
    case clue
    when all_o?
      guess.shuffle
    when only_o_and_x?
      # ["o", "o", "x", "o"]
      shuffle_o_retain_x
    else
      # ["1", "2", "3", "4"]

      # First guess
      # ["2", "2", "1", "6"]
      # ["_", "x", "o", "_"]

      # ["2", "2", "1", "6"]
      # 1 ["2", "2", "1", "1"]*
      # 2 ["2", "2", "3", "1"]
      # 3 ["4", "2", "3", "1"]
      # 4 ["o", "x", "x", "o"]

      # ["4", "2", "3", "1"]
      # ["1", "2", "3", "4"]

      # 1 Replace as many '_' values as possible with an 'o' value (move 'o' values)*
      # 2 ## if no more '_' to replace (move 'o' to), swap 'o' value with another 'o' value until all 'o' values have been swapped (shuffle)
      # 3 Replace each 'o' value with rand(1..6) value (not an '_' value or original 'o' value)
      # 4 Replace each REMAINING (not replaced by an 'o' value) '_' value with a rand(1..6) (not original '_')
      next_guess = underscore_elements_replaced_with_o
      shuffle_o_retain_x if only_o_and_x?
      o_elements_replaced_with_new_random
      remaining_underscore_elements_replaced_with_new_random
    end
  end

  def random_code
    (1..4).inject([]) { |random4, _n| random4 << rand(1..6) }
  end
end
