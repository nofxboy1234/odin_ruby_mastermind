# frozen_string_literal: true

# The MindReadAlgorithm class is responsible for the mastercode in the game
class MindReadAlgorithm
  private

  attr_reader :board, :guess_pegs, :last_guess_pegs

  public

  def initialize(board)
    @board = board

    @guess_pegs = deep_copy(last_pegs)
    @last_guess_pegs = deep_copy(guess_pegs)
  end

  def colour_numbers
    p guess_pegs.map(&:colour_number)
  end

  def run
    p board.all_empty_code_peg_numbers

    random_code_for_u_elements

    puts "\n"
    p colour_numbers
    p guess_pegs.map(&:id)

    move_o_pegs

    p colour_numbers
    p guess_pegs.map(&:id)
    puts "\n\n"

    colour_numbers.join
  end

  private

  def last_pegs
    board.code_rows.last.pegs
  end

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
      u_peg.colour.update(random_numbers.sample.to_s)
      u_peg.update_id("#{u_peg.id}*")
    end
  end

  def deep_copy(object)
    Marshal.load(Marshal.dump(object))
  end

  def move_o_pegs
    permutation = Permutation.new(board, guess_pegs, last_guess_pegs)
    @guess_pegs = permutation.sample
  end
end
