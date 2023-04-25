# frozen_string_literal: true

require_relative 'colorable_string'

# The Board is responsible for the mastercode in the game
class Board
  using ColorableString

  attr_reader :secret_row, :max_rows, :clue_rows, :code_rows

  def initialize(max_rows)
    @code_rows = []
    @clue_rows = []
    @max_rows = max_rows
  end

  def store_secret_row(secret_row)
    @secret_row = secret_row
  end

  def store_code_row(code_row)
    @code_rows << code_row
  end

  def store_clue_row(clue_row)
    @clue_rows << clue_row
  end

  def print_new_line
    puts "\n"
  end

  def show
    print_new_line

    puts "Mastercode".bg_color(:green)
    puts secret_row
    
    print_new_line
    
    puts "Guesses".bg_color(:yellow)
    puts code_rows

    print_new_line

    puts "Clues".bg_color(:pink)
    puts clue_rows

    print_new_line
  end

  def max_rows_reached?
    code_rows.length == max_rows
  end

  def correct_guess?
    code_rows.last.join == secret_row.join
  end

  def all_empty_code_peg_numbers
    numbers = empty_clue_peg_coords.map do |row, column|
      empty_code_peg_number(row, column)
    end

    numbers.uniq
  end

  def secret_numbers
    secret_row.numbers
  end

  private

  def code_peg_at(row, column)
    code_rows[row].pegs[column]
  end

  def empty_code_peg_number(row, column)
    code_peg_at(row, column).colour.number
  end

  def empty_clue_peg_coords
    coords = clue_rows.map.with_index do |clue_row, clue_row_index|
      column_indices = clue_row.empty_clue_pegs_indices
      row_indices = Array.new(column_indices.size, clue_row_index)
      row_indices.zip(column_indices)
    end

    coords.flatten(1)
  end
end
