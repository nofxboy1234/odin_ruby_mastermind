# frozen_string_literal: true

# The Board is responsible for the mastercode in the game
class Board
  attr_reader :code_rows, :secret_row, :max_rows

  def initialize(max_rows)
    @code_rows = []
    @max_rows = max_rows
  end

  def store_secret_row(secret_row)
    @secret_row = secret_row
  end

  def store_code_row(code_row)
    @code_rows << code_row
  end

  def show
    puts secret_row
    puts "\n"
    puts code_rows
  end

  def max_rows_reached?
    code_rows.length == max_rows
  end

  def correct_guess?
    code_rows.last.join == secret_row.join
  end
end
