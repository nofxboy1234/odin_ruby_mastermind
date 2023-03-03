class Guess
  attr_reader :pegs, :clue

  def initialize(pegs, clue = nil)
    @clue = Clue.new(clue)
    @pegs = (0..pegs.size.pred).inject([]) do |array, index|
      array << GuessPeg.new(pegs.at(index), self.clue.at(index), index)
    end
  end

  def join
    pegs.map(&:value).join
  end

  def retain_x_strategy
    case clue
    when clue.all_o?
      pegs.shuffle
    when clue.only_o_and_x?
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
    Array.new(4, rand(1..6))
  end

  def o_elements
    select_elements('o')
  end

  def underscore_elements
    select_elements('_')
  end

  def select_elements(_element)
    pegs.select { |guess_peg| guess_peg.clue == u_element }
  end

  def underscore_elements_replaced_with_o
    underscore_elements.map.with_index do |u_element, index|
      o_element = o_elements.at(index)
      if o_element
        GuessPeg.new(o_element.value, 'Z', u_element.index)
      else
        u_element
      end
    end
  end

  def o_elements_replaced_with_new_random
    o_elements.map do |o_element|
      rand_range = Array((1..6))
      valid_random_numbers = rand_range.reject do |number|
        number == o_element.value ||
          underscore_elements.map(&:value).include?(number)
      end
      GuessPeg.new(rand(valid_random_numbers), 'Z', o_element.index)
    end
  end

  def remaining_underscore_elements_replaced_with_new_random
    underscore_elements.map do { |u_element| 
      u_element.clue == 'Z' }. 
      rand_range = Array((1..6))
      valid_random_numbers = rand_range.reject do |number|
        number == u_element.value
      end
      rand(valid_random_numbers)
    end
  end

  def shuffle_o_retain_x
    shuffled_pegs = pegs.shuffle
    shuffled_pegs.map.with_index do |guess_peg, index|
      clue.at(index) == 'x' ? pegs.at(index) : guess_peg
    end
  end
end
