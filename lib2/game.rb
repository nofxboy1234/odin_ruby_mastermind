# frozen_string_literal: true

# The Game class is responsible for the mastercode in the game
class Game
  attr_reader :stop_playing, :board

  def initialize
    @board = Board.new(12)
  end

  def main_loop(maker, breaker)
    store_secret_row(maker)

    @stop_playing = false
    until stop_playing
      store_code_row(breaker)

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

  def store_secret_row(maker)
    secret_row_menu = CodeRowMenu.new(maker)
    secret_row_menu.main_loop
    board.store_secret_row(secret_row_menu.code)
  end

  def store_code_row(breaker)
    code_row_menu = CodeRowMenu.new(breaker)
    code_row_menu.main_loop
    board.store_code_row(code_row_menu.code)
  end
end
