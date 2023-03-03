class Guess
  attr_reader :value, :clue

  def initialize(value, clue = nil)
    @clue = Clue.new(clue)
    @value = (0..value.size.pred).inject([]) do |array, index|
      array << GuessPeg.new(value.at(index), self.clue.at(index), index)
    end
  end

  def join
    value.map(&:value).join
  end

  def retain_x_strategy
    case clue
    when clue.all_o?
      value.shuffle
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
    (1..4).inject([]) { |random4, _n| random4 << rand(1..6) }
  end

  def o_elements
    # ['value', 'clue', 'index']
    guess_clue_index = []
    guess.each_with_index do |element, i|
      guess_clue_index << [element, clue[i], i]
    end
    guess_clue_index.select { |element| element[1] == 'o' }
  end

  def underscore_clue_index
    value_clue_index = []
    value.each_with_index do |element, index|
      value_clue_index << [element, clue.at(index), index]
    end
    value_clue_index.select { |element| element[1] == '_' }
  end

  def underscore_elements_replaced_with_o
    underscore_clue_index.map.with_index do |element, i|
      if o_elements[i]
        [o_elements[i][0], 'Z', element[2]]
      else
        element
      end
    end
    # [['value', 'Z', 'index'], ['value', '1', 'index']]
  end

  def o_elements_replaced_with_new_random
    o_elements.map.with_index do |o_element, _i|
      rand_range = Array((1..6))
      valid_random_numbers = rand_range.reject do |n|
        n == o_element[0] || underscore_clue_index.map do |u_element|
          u_element[0]
        end.include?(n)
      end
      rand(valid_random_numbers)
    end
  end

  def remaining_underscore_elements_replaced_with_new_random
    underscore_clue_index.reject { |u_ele| u_ele[1] == 'Z' }.map.with_index do |u_element, _i|
      rand_range = Array((1..6))
      valid_random_numbers = rand_range.reject do |n|
        n == u_element[0]
      end
      rand(valid_random_numbers)
    end
  end

  def shuffle_o_retain_x
    shuffled = value.shuffle
    shuffled.map.with_index do |guess_peg, index|
      clue.at(index) == 'x' ? value.at(index) : guess_peg
    end
  end
end
