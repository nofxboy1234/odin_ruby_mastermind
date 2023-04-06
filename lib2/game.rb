# frozen_string_literal: true

# The Game class is responsible for the mastercode in the game
class Game
  attr_reader :stop_playing, :code_row_menu, :board, :secret_row_menu

  def initialize
    @board = Board.new
  end
  
  def main_loop
    @secret_row_menu = CodeRowMenu.new
    secret_row_menu.main_loop
    board.store_secret_row(secret_row_menu.code)
    
    @stop_playing = false
    play until stop_playing
  end
  
  def play
    @code_row_menu = CodeRowMenu.new
    code_row_menu.main_loop
    board.store_code_row(code_row_menu.code)

    board.show
    check_guess
  end

  def check_guess
    if board.correct_guess?
      # player = breaker.instance_of?(Computer) ? 'The computer' : 'You'
      # puts "#{player} deciphered the mastercode!"
      # @is_game_over = true
      puts 'The mastercode was deciphered!'
      @stop_playing = true
    elsif board.max_rows_reached?
      # puts "The mastercode of #{board.mastercode} was not deciphered within 12 guesses"
      # @is_game_over = true
      puts 'The mastercode was not deciphered within 12 guesses'
      @stop_playing = true
    end
  end
end
