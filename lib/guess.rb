class Guess
  @u_pegs_for_all_guesses = []

  class << self
    attr_reader :u_pegs_for_all_guesses
  end

  attr_reader :o_pegs, :u_pegs, :guess_pegs

  def initialize(last_guess_pegs)
    @guess_pegs = deep_copy(last_guess_pegs)
    @o_pegs = deep_copy(guess_pegs.select { |guess_peg| guess_peg.clue == 'o' })
    @u_pegs = deep_copy(guess_pegs.select { |guess_peg| guess_peg.clue == '_' })
    self.class.u_pegs_for_all_guesses.union(@u_pegs)
    # u_pegs_for_all_guesses.union(@u_pegs)

    # @o_and_u_pegs = deep_copy(guess_pegs.select do |guess_peg|
    #   guess_peg.clue == 'o' || guess_peg.clue == '_'
    # end)

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
    # if clue.all_x?
    # you win
    if clue.all_o?
      @guess_pegs = shuffle_o_pegs
    elsif clue.only_o_and_x?
      swap_o_pegs(shuffle_o_pegs)
    elsif clue.all_u?
      # random numbers for each _ excluding all _ so far
      random_code_for_u_elements
    elsif clue.only_u_and_x?
      # random numbers for each _ excluding all _ so far
      random_code_for_u_elements
    else # x, [o, _]
      swap_o_pegs(shuffle_o_pegs)
      random_code_for_u_elements
    end
    guess_pegs
  end

  private

  def random_code_for_u_elements
    # binding.pry
    valid_random_numbers = (1..6).reject do |number|
      self.class.u_pegs_for_all_guesses.map(&:value).include?(number)
    end
    u_pegs.each do |u_peg|
      u_peg.value = valid_random_numbers.sample.to_s
      # original_u_peg = guess_pegs[u_peg.original_index]
      # swap_o_pegs(u_peg, original_u_peg)
    end
  end

  # def random_code
  #   @guess_pegs = (0..3).inject([]) do |array, index|
  #     array << GuessPeg.new(rand(1..6).to_s, '_', index)
  #   end
  # end

  def shuffle_o_pegs
    shuffled_o_pegs = deep_copy(o_pegs)
    shuffled_o_pegs.shuffle! until all_o_pegs_moved?(shuffled_o_pegs)
  end

  def all_o_pegs_moved?(pegs_shuffled)
    check = pegs_shuffled.map.with_index do |peg, index|
      peg.original_index != index
    end
    check.all?(true)
  end

  def swap_o_pegs(shuffled_o_pegs)
    shuffled_o_pegs.each_with_index do |shuffled_o_peg, index|
      o_peg = deep_copy(guess_pegs[index])
      guess_pegs[index] = shuffled_o_peg
      guess_pegs[shuffled_o_peg.original_index] = o_peg
    end
  end
end
