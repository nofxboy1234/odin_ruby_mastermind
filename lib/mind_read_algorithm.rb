# frozen_string_literal: true

# The MindReadAlgorithm class is responsible for the mastercode in the game
class MindReadAlgorithm
  private

  attr_reader :board, :guess_pegs, :last_guess_pegs

  public

  def initialize(board)
    @board = board

    @guess_pegs = deep_copy(board.code_rows.last.pegs)
    @last_guess_pegs = deep_copy(board.code_rows.last.pegs)
  end

  def run
    p board.all_empty_code_peg_numbers
    # p guess_pegs.map(&:id)

    random_code_for_u_elements

    puts "\n"
    p guess_pegs.map(&:colour_number)
    p guess_pegs.map(&:id)

    move_o_pegs

    p guess_pegs.map(&:colour_number)
    p guess_pegs.map(&:id)
    puts "\n\n"

    # p guess_pegs.map(&:id)
    # puts "\n\n"

    guess_pegs.map(&:colour_number).join
  end

  private

  def valid_random_numbers
    ('1'..'6').reject do |number|
      board.all_empty_code_peg_numbers.include?(number)
    end
  end

  def random_code_for_u_elements
    u_pegs_with_index = guess_pegs.each_with_index.select do |_guess_peg, index|
      board.clue_rows.last.pegs[index].empty?
    end

    random_numbers = valid_random_numbers

    u_pegs_with_index.each do |u_peg, _index|
      # random_numbers.delete(last_guess_pegs[index].colour.number) # needed?
      u_peg.colour.update(random_numbers.sample.to_s)
      u_peg.update_id("#{u_peg.id}*")
    end
  end

  def deep_copy(object)
    Marshal.load(Marshal.dump(object))
  end

  def all_x_pegs_valid?(permutation)
    x_pegs_with_index = guess_pegs.each_with_index.select do |_guess_peg, index|
      board.clue_rows.last.pegs[index].match?
    end

    x_pegs_with_index.all? do |x_peg, original_index|
      x_peg_valid?(x_peg, original_index, permutation)
    end
  end

  def all_o_pegs_valid?(permutation)
    o_pegs_with_index = guess_pegs.each_with_index.select do |_guess_peg, index|
      board.clue_rows.last.pegs[index].partial?
    end

    o_pegs_with_index.all? do |o_peg, original_index|
      o_peg_valid?(o_peg, original_index, permutation)
    end
  end

  def all_permutations
    guess_pegs.permutation(guess_pegs.size).to_a.uniq
  end

  def valid_o_permutations
    all_permutations.select do |permutation|
      all_o_pegs_valid?(permutation)
    end
  end

  def valid_ox_permutations
    all_permutations.select do |permutation|
      all_o_pegs_valid?(permutation) && all_x_pegs_valid?(permutation)
    end
  end

  def x_peg_valid?(x_peg, original_index, permutation)
    x_peg_index_in_permutation = permutation.index(x_peg)
    original_index == x_peg_index_in_permutation &&
      x_peg.colour.number == permutation[x_peg_index_in_permutation].colour.number
  end

  def different_value_if_target_index_was_an_o?(o_peg, o_peg_index_in_permutation)
    if board.clue_rows.last.pegs[o_peg_index_in_permutation].partial?
      last_guess_pegs[o_peg_index_in_permutation].colour.number != o_peg.colour.number
    elsif board.clue_rows.last.pegs[o_peg_index_in_permutation].empty?
      true
    elsif board.clue_rows.last.pegs[o_peg_index_in_permutation].match?
      false
    end
  end

  def o_peg_valid?(o_peg, original_index, permutation)
    o_peg_index_in_permutation = permutation.index(o_peg)
    original_index != o_peg_index_in_permutation &&
      o_peg.colour.number == permutation[o_peg_index_in_permutation].colour.number &&
      different_value_if_target_index_was_an_o?(o_peg, o_peg_index_in_permutation)
  end

  def move_o_pegs
    if board.clue_rows.last.only_partials?
      @guess_pegs = valid_o_permutations.sample
    elsif board.clue_rows.last.partials_and_matches?
      @guess_pegs = valid_ox_permutations.sample
    end
  end
end
