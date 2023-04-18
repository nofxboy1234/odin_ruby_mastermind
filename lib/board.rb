# frozen_string_literal: true

# The Board is responsible for the mastercode in the game
class Board
  attr_reader :secret_row, :max_rows, :clue_rows, :code_rows

  def initialize(max_rows)
    @code_rows = []
    @clue_rows = []
    @max_rows = max_rows
    @empty_clue_numbers = []
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

  # def store_empty_clue_numbers
  #   @empty_clue_numbers = all_empty_code_peg_numbers
  # end

  def print_new_line
    puts "\n"
  end

  def show
    puts secret_row
    print_new_line
    puts code_rows
    # print_new_line
    # p code_row_ids
    print_new_line
    puts clue_rows
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
  
  def secret_numbers_with_index
    secret_numbers.each_with_index.map do |number, index|
      [number, index]
    end
  end
  
  private

  # def code_row_ids
  #   code_rows.map do |code_row|
  #     code_row.pegs.map(&:id)
  #   end
  # end

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
