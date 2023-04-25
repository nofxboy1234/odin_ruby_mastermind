# frozen_string_literal: true

require_relative 'colorable_string'

# The Game class is responsible for the mastercode in the game
class Game
  using ColorableString

  attr_reader :stop_playing, :board, :menu_choice_number

  def initialize(menu_choice_number)
    @board = Board.new(12)
    @menu_choice_number = menu_choice_number
  end

  def clear_screen
    puts "\033[2J"
    puts "\033[H"
  end

  def main_loop
    clear_screen

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
    code_row = store_code_row
    store_clue_row(code_row)
  end

  def check_guess
    if board.correct_guess?
      puts "The mastercode was deciphered in #{board.code_rows.size} turns!\n".fg_color(:green)
      @stop_playing = true
      sleep(2)
    elsif board.max_rows_reached?
      puts "The mastercode was not deciphered within #{board.max_rows} turns!\n".fg_color(:pink)
      @stop_playing = true
      sleep(2)
    end
  end

  def maker
    case menu_choice_number
    when '1'
      CodeMaker.new(Computer.new(board))
    when '2'
      CodeMaker.new(Human.new(board))
    end
  end

  def breaker
    case menu_choice_number
    when '1'
      CodeBreaker.new(Human.new(board))
    when '2'
      CodeBreaker.new(Computer.new(board))
    end
  end

  def store_secret_row
    secret_row_menu = CodeRowMenu.new(maker)
    secret_row_menu.main_loop
    board.store_secret_row(secret_row_menu.code)
  end

  def store_code_row
    code_row_menu = CodeRowMenu.new(breaker)
    code_row_menu.main_loop

    code_row = code_row_menu.code

    board.store_code_row(code_row)
    code_row
  end

  def clue_row
    last_code_row = board.code_rows.last

    ClueRow.new(last_code_row, board)
  end

  def store_clue_row(code_row)
    board.secret_row.initialize_tally
    current_clue_row = clue_row
    board.store_clue_row(current_clue_row)
    code_row.store_clues(current_clue_row)
  end
end
