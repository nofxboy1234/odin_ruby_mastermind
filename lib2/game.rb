# frozen_string_literal: true

# The Game class is responsible for the mastercode in the game
class Game
  attr_reader :stop_playing, :choice, :code_row_menu, :board

  def initialize
    @board = Board.new
    @code_row_menu = CodeRowMenu.new
  end

  def main_loop(secret_row_menu)
    board.store_secret_row(secret_row_menu.code)

    @choice = nil
    @stop_playing = false
    until stop_playing
      play
      @stop_playing = true
    end
  end

  def play
    code_row_menu.main_loop
    board.store_code_row(code_row_menu.code)
    board.show
    # check_guess
  end

  # def check_guess
  #   if correct_guess?
  #     player = breaker.instance_of?(Computer) ? 'The computer' : 'You'
  #     puts "#{player} deciphered the mastercode!"
  #     @is_game_over = true
  #   elsif board.max_rows_reached?
  #     puts "The mastercode of #{board.mastercode} was not deciphered within 12 guesses"
  #     @is_game_over = true
  #   end
  # end

  # def correct_guess?
  #   board.last_guess.join == board.mastercode
  # end
end
