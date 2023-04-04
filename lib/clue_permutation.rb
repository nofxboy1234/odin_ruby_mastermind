# frozen_string_literal: true

# The CluePermutaion class is responsible for calculating
# various permutations of clue pegs.
class CluePermutation
  def self.total_different_patterns_in_mastermind
    (1..6).to_a.repeated_permutation(4).to_a.size # 1296
  end

  def self.all_x
    first_peg = CodePeg.new('1', 'x')
    second_peg = CodePeg.new('2', 'x')
    third_peg = CodePeg.new('3', 'x')
    fourth_peg = CodePeg.new('4', 'x')
    [] << first_peg << second_peg << third_peg << fourth_peg
  end

  def self.all_valid_clue_permutations
    base_permutation = %w[_ o x].repeated_permutation(4).to_a.uniq
    oxxx_permutation = %w[o x x x].permutation(4).to_a.uniq
    xxxx_permutation = [%w[x x x x]]
    base_permutation.difference(oxxx_permutation, xxxx_permutation)
  end

  def self.test_specific_clue
    first_peg = CodePeg.new('4', 'o')
    second_peg = CodePeg.new('2', '_')
    third_peg = CodePeg.new('3', 'o')
    fourth_peg = CodePeg.new('4', 'o')
    [] << first_peg << second_peg << third_peg << fourth_peg
  end
end
