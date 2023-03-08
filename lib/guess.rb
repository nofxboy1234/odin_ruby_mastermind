class Guess
  attr_reader :guess_pegs, :o_pegs, :u_pegs

  def initialize(guess_pegs)
    @guess_pegs = deep_copy(guess_pegs)
    @o_pegs = deep_copy(guess_pegs.select { |guess_peg| guess_peg.clue == 'o' })
    @u_pegs = deep_copy(guess_pegs.select { |guess_peg| guess_peg.clue == '_' })

    mind_read_strategy
  end

  def deep_copy(object)
    Marshal.load(Marshal.dump(object))
  end

  def join
    guess_pegs.map(&:value).join
  end

  def clue
    Clue.new(guess_pegs.map(&:clue))
  end

  def mind_read_strategy
    case clue
    when clue.all_x?
      # you win
    when clue.all_o?
      guess_pegs.shuffle
    when clue.only_o_and_x?
      shuffle_o_pegs
    when clue.all_underscore?
      # random_code excluding the underscore values
    when clue.all_nil?
      random_code
    else
      # ["1", "2", "3", "4"]

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

      # next_guess = underscore_elements_replaced_with_o
      # shuffle_o_pegs if only_o_and_x?
      # o_elements_replaced_with_new_random
      # remaining_underscore_elements_replaced_with_new_random
      o_pegs.each do |o_peg|
        if u_pegs.all? { |u_peg| u_peg.clue == '*' }
          move_o_to_another_random_o(o_peg)
        else
          move_o_to_random_underscore(o_peg)
        end
      end
    end
  end

  private

  def random_code
    @guess_pegs = Array.new(4, rand(1..6)).map.with_index do |number, index|
      GuessPeg.new(number, nil, index)
    end
  end

  def move_o_to_another_random_o(o_peg)
    peg_to_replace = o_pegs.sample
    peg_to_replace.value = o_peg.value
    peg_to_replace.clue = '*'

    valid_random_numbers = rand_range.reject do |number|
      number == o_peg.value ||
        u_pegs.map(&:value).include?(number)
    end
    o_peg.value = rand(valid_random_numbers)
    o_peg.clue = '*'
  end

  def move_o_to_random_underscore(o_peg)
    peg_to_replace = u_pegs.sample
    peg_to_replace.value = o_peg.value
    peg_to_replace.clue = '*'

    valid_random_numbers = rand_range.reject do |number|
      number == o_peg.value ||
        u_pegs.map(&:value).include?(number)
    end
    o_peg.value = rand(valid_random_numbers)
    o_peg.clue = '*'
  end

  def underscore_elements_replaced_with_o
    u_pegs.map.with_index do |element, index|
      o_element = o_pegs.at(index)
      if o_element
        GuessPeg.new(o_element.value, 'Z', element.index)
      else
        element
      end
    end
  end

  def o_elements_replaced_with_new_random
    o_pegs.map do |o_element|
      rand_range = Array((1..6))
      valid_random_numbers = rand_range.reject do |number|
        number == o_element.value ||
          u_pegs.map(&:value).include?(number)
      end
      GuessPeg.new(rand(valid_random_numbers), 'Z', o_element.index)
    end
  end

  def remaining_underscore_elements_replaced_with_new_random
    # underscore_elements.map do { |u_element|
    #   u_element.clue == 'Z' }.
    #   rand_range = Array((1..6))
    #   valid_random_numbers = rand_range.reject do |number|
    #     number == u_element.value
    #   end
    #   rand(valid_random_numbers)
    # end
  end

  def shuffled?(array1, array2)
    array1.map(&:value) != array2.map(&:value)
  end

  def swap_pegs(peg1, peg2)
    value1 = peg1.value
    value2 = peg2.value
    peg2.value = value1
    peg2.clue = '*'
    peg1.value = value2
    peg1.clue = '*'
  end

  def shuffle_o_pegs
    o_pegs_shuffled = o_pegs
    o_pegs_shuffled = o_pegs.shuffle until shuffled?(o_pegs_shuffled, o_pegs)

    o_pegs_shuffled.each do |shuffled_o_peg|
      original_guess_peg = guess_pegs[shuffled_o_peg.original_index]
      swap_pegs(shuffled_o_peg, original_guess_peg)
    end
  end
end
