# frozen_string_literal: true

# The Game class is responsible for the mastercode in the game
class Game
  attr_reader :stop_playing, :board, :maker, :breaker

  def initialize(maker, breaker)
    @maker = maker
    @breaker = breaker

    @board = Board.new(12)

    main_loop
  end

  def main_loop
    store_secret_row

    @stop_playing = false
    until stop_playing
      store_code_and_clue

      board.show
      check_guess
    end
  end

  private

  def store_code_and_clue
    store_code_row
    store_clue_row
  end

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
    secret_row_menu = CodeRowMenu.new(maker)
    board.store_secret_row(secret_row_menu.code)
  end

  def store_code_row
    code_row_menu = CodeRowMenu.new(breaker)
    board.store_code_row(code_row_menu.code)
  end

  def clue_row
    # Get the last guess pegs on the board
    # Get the mastercode tally
    # Check if any guess peg matches left for each guess peg value in the last guess
    # Calculate the clue
  end

  def store_clue_row
    board.store_clue_row(clue_row)
  end
end
