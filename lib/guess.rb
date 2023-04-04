# frozen_string_literal: true

# The Guess class is responsible for calculating the next guess for
# a Computer player
class Guess
  @u_values_for_all_guesses = []

  class << self
    attr_accessor :u_values_for_all_guesses
  end

  attr_reader :u_pegs, :clue, :code_pegs, :last_code_pegs

  def initialize(last_guess_peg_row)
    @code_pegs = deep_copy(last_guess_peg_row)
    @last_code_pegs = deep_copy(last_guess_peg_row)
    @clue = CluePegRow.new(@code_pegs.map(&:clue))
    @u_pegs = @code_pegs.select { |guess_peg| guess_peg.clue == '_' }
    u_values = @u_pegs.map(&:value)
    Guess.u_values_for_all_guesses = Guess.u_values_for_all_guesses.union(u_values)

    mind_read_strategy
  end

  def deep_copy(object)
    Marshal.load(Marshal.dump(object))
  end

  def print_guess_pegs
    p code_pegs.map(&:value)
    p code_pegs.map(&:id)
    p code_pegs.map(&:clue)
    puts "\n"
  end

  def mind_read_strategy
    print_guess_pegs
    puts "#{Guess.u_values_for_all_guesses} <= not allowed _ values"

    move_o_pegs if clue.any_o?
    random_code_for_u_elements

    print_guess_pegs

    code_pegs
  end

  private

  def valid_random_numbers
    ('1'..'6').reject do |number|
      Guess.u_values_for_all_guesses.include?(number)
    end
  end

  def random_code_for_u_elements
    rearranged_u_pegs_with_index = code_pegs.each_with_index.select do |guess_peg, _index|
      guess_peg.clue == '_'
    end

    rearranged_u_pegs_with_index.each do |u_peg, index|
      valid_random_numbers.delete(last_code_pegs[index].value)
      u_peg.value = valid_random_numbers.sample.to_s
    end
  end

  def all_permutations
    code_pegs.permutation(code_pegs.size).to_a.uniq
  end

  def all_x_pegs_valid(permutation)
    x_pegs_with_index = code_pegs.each_with_index.select do |guess_peg, _index|
      guess_peg.clue == 'x'
    end

    x_pegs_with_index.all? do |x_peg, original_index|
      x_peg_valid?(x_peg, original_index, permutation)
    end
  end

  def all_o_pegs_valid(permutation)
    o_pegs_with_index = code_pegs.each_with_index.select do |guess_peg, _index|
      guess_peg.clue == 'o'
    end

    o_pegs_with_index.all? do |o_peg, original_index|
      o_peg_valid?(o_peg, original_index, permutation)
    end
  end

  def valid_permutations
    all_permutations.select do |permutation|
      all_x_pegs_valid(permutation) && all_o_pegs_valid(permutation)
    end
  end

  def x_peg_valid?(x_peg, original_index, permutation)
    x_peg_index_in_permutation = permutation.index(x_peg)
    original_index == x_peg_index_in_permutation &&
      x_peg.value == permutation[x_peg_index_in_permutation].value
  end

  def different_value_if_last_peg_was_an_o?(o_peg, o_peg_index_in_permutation)
    if last_code_pegs[o_peg_index_in_permutation].clue == 'o'
      return last_code_pegs[o_peg_index_in_permutation].value != o_peg.value
    end

    true # for all '_' pegs
  end

  def o_peg_valid?(o_peg, original_index, permutation)
    o_peg_index_in_permutation = permutation.index(o_peg)
    original_index != o_peg_index_in_permutation &&
      o_peg.value == permutation[o_peg_index_in_permutation].value &&
      different_value_if_last_peg_was_an_o?(o_peg, o_peg_index_in_permutation)
  end

  def move_o_pegs
    @code_pegs = valid_permutations.sample || @code_pegs
  end
end
