class Guess
  @u_values_for_all_guesses = []
  @guess_pegs_history = []

  class << self
    attr_accessor :u_values_for_all_guesses, :guess_pegs_history
  end

  attr_reader :u_pegs, :guess_pegs, :o_and_u_pegs, :clue

  def initialize(last_guess_pegs)
    @guess_pegs = deep_copy(last_guess_pegs)
    Guess.guess_pegs_history << guess_pegs
    @clue = Clue.new(guess_pegs.map(&:clue))
    @u_pegs = guess_pegs.select { |guess_peg| guess_peg.clue == '_' }
    @o_and_u_pegs = guess_pegs.select do |guess_peg|
      %w[o _].include?(guess_peg.clue)
    end

    u_values = u_pegs.map { |element| element.value }
    Guess.u_values_for_all_guesses = Guess.u_values_for_all_guesses.union(u_values)

    mind_read_strategy
  end

  def deep_copy(object)
    Marshal.load(Marshal.dump(object))
  end

  def mind_read_strategy
    move_o_pegs unless clue.all_u?
    random_code_for_u_elements

    binding.pry
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
    guess_pegs_history_values = Guess.guess_pegs_history.map do |pegs|
      pegs.map(&:value)
    end
    # binding.pry

    valid_permutations = all_o_and_u_permutations.reject do |permutation|
      all_o_and_u_permutations.first[0].value == permutation[0].value ||
        all_o_and_u_permutations.first[1].value == permutation[1].value ||
        all_o_and_u_permutations.first[2].value == permutation[2].value ||
        all_o_and_u_permutations.first[3].value == permutation[3].value
    end

    random_permutation = valid_permutations.sample
    random_permutation.each_with_index do |guess_peg, index|
      guess_pegs[index] = guess_peg
    end
  end
end
