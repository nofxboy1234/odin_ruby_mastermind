class Guess
  @u_values_for_all_guesses = []
  @guess_history = []

  class << self
    attr_accessor :u_values_for_all_guesses, :guess_history
  end

  attr_reader :u_pegs, :guess_pegs, :o_and_u_pegs, :clue

  def clues_to_values_history
    clues_values = {}
    Guess.guess_history.each do |peg_row|
      if !clues_values[peg_row.map(&:clue)]
        clues_values[peg_row.map(&:clue)] = [peg_row.map(&:value)]
      else
        clues_values[peg_row.map(&:clue)] << peg_row.map(&:value)
      end
    end
    clues_values
  end

  def initialize(last_guess_peg_row)
    @guess_pegs = deep_copy(last_guess_peg_row)
    guess_pegs.each_with_index do |guess_peg, index|
      ids = { 0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd' }
      guess_peg.id = ids[index].upcase
    end

    Guess.guess_history << guess_pegs

    @clue = Clue.new(guess_pegs.map(&:clue))
    @u_pegs = guess_pegs.select { |guess_peg| guess_peg.clue == '_' }
    @o_and_u_pegs = guess_pegs.select do |guess_peg|
      %w[o _].include?(guess_peg.clue)
    end

    u_values = u_pegs.map(&:value)
    Guess.u_values_for_all_guesses = Guess.u_values_for_all_guesses.union(u_values)

    mind_read_strategy
  end

  def deep_copy(object)
    Marshal.load(Marshal.dump(object))
  end

  def print_guess_pegs
    # p %w[1 2 3 4]
    p guess_pegs.map(&:value)
    p guess_pegs.map(&:id)
    p guess_pegs.map(&:clue)
    puts "\n"
  end

  def mind_read_strategy
    binding.pry if clue.all_x?

    print_guess_pegs
    p Guess.u_values_for_all_guesses

    move_o_pegs if clue.any_o?
    random_code_for_u_elements

    print_guess_pegs
    # binding.pry

    guess_pegs
  end

  private

  def random_code_for_u_elements
    valid_random_numbers = ('1'..'6').reject do |number|
      Guess.u_values_for_all_guesses.include?(number)
    end
    u_pegs.each do |u_peg|
      u_peg.value = valid_random_numbers.sample.to_s
    end
  end

  def all_o_and_u_permutations
    o_and_u_pegs.permutation(o_and_u_pegs.size).to_a.uniq
  end

  def move_o_pegs
    valid_permutations = all_o_and_u_permutations.reject do |permutation|
      clues_to_values_history[clue.value].include?(permutation.map(&:value)) ||
        permutation.each_with_index.any? do |_peg, index|
          all_o_and_u_permutations.first[index].value == permutation[index].value
        end
    end
    # binding.pry

    random_permutation = valid_permutations.sample

    o_and_u_clues = clue.value.each_with_index.reject do |clue_value, _index|
      clue_value == 'x'
    end
    o_and_u_indices = o_and_u_clues.map { |_clue_value, index| index }

    o_and_u_indices.each_with_index do |o_or_u_index, index|
      guess_pegs[o_or_u_index] = random_permutation[index]
    end
  end
end
