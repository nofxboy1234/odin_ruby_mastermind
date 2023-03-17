class Guess
  @u_values_for_all_guesses = []
  @taken_indices_history_per_peg = {}

  class << self
    attr_accessor :u_values_for_all_guesses, :taken_indices_history_per_peg
  end

  attr_reader :o_pegs, :u_pegs, :guess_pegs

  def initialize(last_guess_pegs)
    @guess_pegs = deep_copy(last_guess_pegs)
    # @o_pegs = guess_pegs.each.select { |guess_peg| guess_peg.clue == 'o' }
    @u_pegs = guess_pegs.each.select { |guess_peg| guess_peg.clue == '_' }
    u_values = u_pegs.map { |element| element[1] }
    Guess.u_values_for_all_guesses = Guess.u_values_for_all_guesses.union(u_values)

    mind_read_strategy
  end

  def deep_copy(object)
    Marshal.load(Marshal.dump(object))
  end

  def clue
    Clue.new(guess_pegs.map(&:clue))
  end

  def mind_read_strategy
    move_o_pegs
    random_code_for_u_elements

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

  def all_o_permutations
    [0, 1, 2, 3].permutation(4).to_a.uniq
  end

  def o_permutations_starting_with(number)
    all_o_permutations.select { |permutation| permutation.first == number }
  end

  def move_o_pegs
    reference_indices = [0, 1, 2, 3]
    reference_indices[1..3].each do |ref_index|
      permutations = o_permutations_starting_with(ref_index)
      all_zipped = []
      permutations.each do |permutation|
        all_zipped << reference_indices.zip(permutation)
      end

      binding.pry

      swap_indices = all_zipped.reject do |swap_pairs|
        swap_pairs.any? do |guess_index, permutation_index|
          guess_index == permutation_index ||
            guess_pegs[guess_index].value ==
              guess_pegs[permutation_index].value
        end
      end

      next if swap_indices.size.zero?

      sorted_swap_groups = swap_indices.map do |pairs|
        pairs.map(&:sort).uniq
      end

      only_first_swap_group = sorted_swap_groups.each_with_index.select do |_swap_group, index|
        index.zero?
      end.map { |swap_group, _index| swap_group }

      found_swap_group = only_first_swap_group.size.positive?

      # sorted_swap_groups.each do |swap_group|
      only_first_swap_group.each do |swap_group|
        swap_group.each do |guess_index, permutation_index|
          temp = guess_pegs[guess_index]
          guess_pegs[guess_index] = guess_pegs[permutation_index]
          guess_pegs[permutation_index] = temp
        end
      end
      break if found_swap_group
    end
  end
end
