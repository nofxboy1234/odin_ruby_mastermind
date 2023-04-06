# frozen_string_literal: true

# The Board is responsible for the mastercode in the game
class Board
  attr_reader :code_rows, :secret_row

  def initialize
    @code_rows = []
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
end
