class Guess
  attr_reader :guess_pegs, :o_pegs, :u_pegs, :o_and_u_pegs

  def initialize(guess_pegs)
    @guess_pegs = deep_copy(guess_pegs)
    @o_pegs = deep_copy(guess_pegs.select { |guess_peg| guess_peg.clue == 'o' })
    @u_pegs = deep_copy(guess_pegs.select { |guess_peg| guess_peg.clue == '_' })
    @o_and_u_pegs = deep_copy(guess_pegs.select do |guess_peg|
      guess_peg.clue == 'o' || guess_peg.clue == '_'
    end)

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
      shuffle_pegs(o_pegs)
    when clue.only_u_and_x?
      # random numbers for each _ updated into guess_pegs
    when clue.all_u?
      # first guess OR a later fully incorrect guess: random_code excluding the underscore values
      random_code
    else
      shuffle_pegs(o_and_u_pegs)
      replace_remaining_u_elements
    end
  end

  private

  def random_code
    @guess_pegs = Array.new(4, rand(1..6)).map.with_index do |number, index|
      GuessPeg.new(number, nil, index)
    end
  end

  def replace_remaining_u_elements
    valid_random_numbers = (1..6).reject do |number|
      u_pegs.map(&:value).include?(number)
    end
    u_pegs.each do |u_peg|
      u_peg.value = rand(valid_random_numbers)
      original_u_peg = guess_pegs[u_peg.original_index]
      swap_new_and_original_peg(u_peg, original_u_peg)
    end
  end

  def shuffled?(array1, array2)
    array1.map(&:value) != array2.map(&:value)
  end

  def swap_new_and_original_peg(peg1, peg2)
    value1 = peg1.value
    value2 = peg2.value
    peg2.value = value1
    peg2.clue = '*'
    peg1.value = value2
    peg1.clue = '*'
  end

  def shuffle_pegs(pegs)
    pegs_shuffled = pegs
    pegs_shuffled = pegs.shuffle until shuffled?(pegs_shuffled, pegs)

    pegs_shuffled.each do |shuffled_o_or_u_peg|
      original_guess_peg = guess_pegs[shuffled_o_or_u_peg.original_index]
      swap_new_and_original_peg(shuffled_o_or_u_peg, original_guess_peg)
    end
  end
end
