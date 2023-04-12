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
    binding.pry
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

  def exact_match?(number, index)
    number == board.secret_row_numbers[index]
  end

  def partial_match?(number)
    board.secret_row_numbers.any?(number)
  end

  def calculate_clue(number, secret_row_tally, index)
    if exact_match?(number, index)
      secret_row_tally[number] -= 1
      'x'
    elsif partial_match?(number)
      secret_row_tally[number] -= 1
      'o'
    else
      '_'
    end
  end

  def guess_peg_matches_remaining?(number, secret_row_tally)
    secret_row_tally.any? do |secret_row_number, tally|
      pegs_equal = number == secret_row_number
      positive_tally = tally.positive?

      pegs_equal && positive_tally
    end
  end

  def numbers_index_with_matches_remaining(matches_remaining, last_code_row)
    matches_remaining.each_with_index.filter_map do |match_left, index|
      last_code_row.numbers_with_index[index] if match_left
    end
  end

  def clue_row
    # Get the last guess pegs on the board
    last_code_row = board.code_rows.last

    # Get the mastercode tally
    secret_row_tally = board.secret_row_tally

    # for each guess peg value in the last code row
    matches_remaining = last_code_row.numbers_with_index.map do |number, index|
      guess_peg_matches_remaining?(number, secret_row_tally)
    end
    
    # Calculate the clue
    potential_matches = numbers_index_with_matches_remaining(matches_remaining, last_code_row)
    clue = potential_matches.map do |number, index|
      calculate_clue(number, secret_row_tally, index)
    end

    ClueRow.new(clue)
  end

  def store_clue_row
    board.store_clue_row(clue_row)
  end
end
