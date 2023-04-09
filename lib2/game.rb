# frozen_string_literal: true

# The Game class is responsible for the mastercode in the game
class Game
  attr_reader :stop_playing, :code_row_menu, :board, :secret_row_menu

  def initialize
    @board = Board.new(12)
  end

  def main_loop
    store_secret_row

    @stop_playing = false
    until stop_playing
      store_code_row

      board.show
      check_guess
    end
  end

  private

  def check_guess
    if board.correct_guess?
      puts 'The mastercode was deciphered!'
      @stop_playing = true
    elsif board.max_rows_reached?
      puts 'The mastercode was not deciphered within 12 guesses'
      @stop_playing = true
    end
  end

  def store_secret_row
    @secret_row_menu = CodeRowMenu.new
    secret_row_menu.main_loop
    board.store_secret_row(secret_row_menu.code)
  end

  def store_code_row
    @code_row_menu = CodeRowMenu.new
    code_row_menu.main_loop
    board.store_code_row(code_row_menu.code)
  end
end
