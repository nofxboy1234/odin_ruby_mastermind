# frozen_string_literal: true

require_relative 'colorable_string'

# The MindReadAlgorithm class is responsible for the mastercode in the game
class MindReadAlgorithm
  using ColorableString

  private

  attr_reader :board, :guess_pegs, :last_guess_pegs

  public

  def initialize(board)
    @board = board

    @guess_pegs = deep_copy(last_pegs)
    @last_guess_pegs = deep_copy(guess_pegs)
  end

  def peg_colour_numbers
    guess_pegs.map(&:colour_number)
  end

  def print_peg_colour_numbers
    p peg_colour_numbers
  end

  def peg_ids
    guess_pegs.map(&:id)
  end

  def print_peg_ids
    p peg_ids
  end

  def run
    # p board.all_empty_code_peg_numbers

    move_o_pegs if board.clue_rows.last.any_partials?

    puts "\n"
    puts "After Computer moves any partial matches around:".bg_color(:orange)
    print_peg_colour_numbers
    print_peg_ids

    random_code_for_u_elements

    puts "After Computer chooses new numbers for any empty matches:".bg_color(:cyan)
    print_peg_colour_numbers
    print_peg_ids
    puts "\n\n"

    peg_colour_numbers.join
  end

  private

  def last_pegs
    board.code_rows.last.pegs
  end

  def last_clue_pegs
    board.clue_rows.last.pegs
  end

  def u_pegs_with_index
    guess_pegs.each_with_index.select do |guess_peg, _index|
      guess_peg.clue_peg.empty?
    end
  end

  def random_code_for_u_elements
    u_pegs_with_index.each do |u_peg, index|
      restriction = EmptyPegRestriction.new(board, index, last_guess_pegs, last_clue_pegs)
      u_peg.update_with_random_number(restriction)
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
