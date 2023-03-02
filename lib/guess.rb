class Guess
  attr_reader :value

  def initialize(value = [])
    @value = value
  end

  def at(index)
    value.at(index)
  end

  def o_elements
    # ['value', 'clue', 'index']
    guess_clue_index = []
    guess.each_with_index do |element, i|
      guess_clue_index << [element, clue[i], i]
    end
    guess_clue_index.select { |element| element[1] == 'o' }
  end

  def underscore_elements
    # ['value', 'clue', 'index']
    guess_clue_index = []
    guess.split('').each_with_index do |element, i|
      guess_clue_index << [element, clue[i], i]
    end
    guess_clue_index.select { |element| element[1] == '_' }
  end

  def underscore_elements_replaced_with_o
    underscore_elements.map.with_index do |element, i|
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
        n == o_element[0] || underscore_elements.map do |u_element|
          u_element[0]
        end.include?(n)
      end
      rand(valid_random_numbers)
    end
  end

  def remaining_underscore_elements_replaced_with_new_random
    underscore_elements.reject { |u_ele| u_ele[1] == 'Z' }.map.with_index do |u_element, _i|
      rand_range = Array((1..6))
      valid_random_numbers = rand_range.reject do |n|
        n == u_element[0]
      end
      rand(valid_random_numbers)
    end
  end

  def shuffle_o_retain_x
    shuffled = guess.shuffle
    shuffled.map.with_index { |element, i| clue[i] == 'x' ? guess.at(i) : element }
  end

  def only_o_and_x?
    clue.include?('o') && clue.include?('x') && clue.none?('_')
  end

  def all_o?
    clue.all?('o')
  end
end
