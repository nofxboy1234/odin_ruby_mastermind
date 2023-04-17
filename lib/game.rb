# frozen_string_literal: true

# The Game class is responsible for the mastercode in the game
class Game
  attr_reader :stop_playing, :board, :menu_choice_number

  def initialize(menu_choice_number)
    @board = Board.new(12)
    @menu_choice_number = menu_choice_number
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

  def maker
    case menu_choice_number
    when '1'
      CodeMaker.new(Computer.new(board))
    when '2'
      CodeMaker.new(Human.new)
    end
  end

  def breaker
    case menu_choice_number
    when '1'
      CodeBreaker.new(Human.new)
    when '2'
      CodeBreaker.new(Computer.new(board))
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
    last_code_row = board.code_rows.last

    ClueRow.new(last_code_row, board)
  end

  def store_clue_row
    board.secret_row.initialize_tally
    board.store_clue_row(clue_row)
  end
end
