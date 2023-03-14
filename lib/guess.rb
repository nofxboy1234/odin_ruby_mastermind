class Guess
  @u_values_for_all_guesses = []

  class << self
    attr_accessor :u_values_for_all_guesses
  end

  attr_reader :o_pegs, :u_pegs, :o_and_u_pegs, :guess_pegs

  def initialize(last_guess_pegs)
    @guess_pegs = deep_copy(last_guess_pegs)
    @o_pegs = guess_pegs.select { |guess_peg| guess_peg.clue == 'o' }
    @u_pegs = guess_pegs.select { |guess_peg| guess_peg.clue == '_' }
    u_values = u_pegs.map(&:value)
    self.class.u_values_for_all_guesses = self.class.u_values_for_all_guesses.union(u_values)
    @o_and_u_pegs = guess_pegs.select { |guess_peg| %w[o _].include?(guess_peg.clue) }

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
    # binding.pry
    if clue.all_o?
      @guess_pegs = move_o_pegs
    elsif clue.only_o_and_x?
      @guess_pegs = move_o_pegs
    elsif clue.all_u?
      random_code_for_u_elements
    elsif clue.only_u_and_x?
      random_code_for_u_elements
    else # x, [o, _]
      @guess_pegs = move_o_pegs
      random_code_for_u_elements
    end
    binding.pry
    guess_pegs
  end

  private

  def random_code_for_u_elements
    valid_random_numbers = ('1'..'6').reject do |number|
      self.class.u_values_for_all_guesses.include?(number)
    end
    u_pegs.each do |u_peg|
      u_peg.value = valid_random_numbers.sample.to_s
    end
  end

  def o_and_u_positions
    o_and_u_pegs.map(&:original_index)
  end

  def valid_positions(all_valid_positions, peg)
    all_valid_positions.reject! do |position|
      position == peg.original_index
    end
  end

  def move_o_pegs
    new_guess_pegs = deep_copy(guess_pegs)
    all_valid_positions = deep_copy(o_and_u_positions)
    guess_pegs.each_with_index do |peg, index|
      next unless peg.clue == 'o'

      # all_valid_positions = valid_positions(all_valid_positions, peg)
      valid_positions(all_valid_positions, peg)

      next unless all_valid_positions.size.positive?

      random_position = all_valid_positions.sample

      # all_valid_positions.reject! do |position|
      #   position == random_position
      # end

      temp = new_guess_pegs[random_position]
      new_guess_pegs[random_position] = new_guess_pegs[index]
      new_guess_pegs[index] = temp
      # puts 'hello'
    end
    new_guess_pegs
  end

  def all_o_pegs_moved?(shuffled_pegs)
    o_pegs_with_index = shuffled_pegs.each_with_index.select do |element, _index|
      element.clue == 'o'
    end

    check = o_pegs_with_index.map do |o_peg_with_index|
      o_peg = o_peg_with_index[0]
      new_index = o_peg_with_index[1]
      o_peg.original_index != new_index
    end
    check.all?(true)
  end
end
