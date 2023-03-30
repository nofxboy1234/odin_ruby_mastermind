# frozen_string_literal: true

# The Game class is responsible for running the game loop and checking for
# a winner
class Game
  attr_reader :board, :maker, :breaker

  def initialize
    @min_colour_number = 1
    # @min_colour_number = 0
    @max_colour_number = 6
    @board = Board.new

    set_up
  end

  private

  def show_menu
    puts "Welcome to Mastermind!\n"
    puts "Please choose an option by entering '1', '2', or '3':"
    puts '1. Play as the CodeBreaker'
    puts '2. Play as the CodeMaker'
    puts '3. Quit'
  end

  def play_again_or_end_game
    prompt_for_play_again
    answer = gets.chomp.strip.downcase

    if answer == 'y'
      set_up
    else
      puts 'Thanks for playing, goodbye :)!'
    end
  end

  def show_invalid_menu_choice_message
    puts 'The menu choice you entered was invalid. Please try again.'
  end

  def show_game_end_message
    puts 'Thanks for playing, goodbye :)!'
  end

  def init_players(choice)
    chosen = choice
    case chosen
    when '1'
      @maker = Computer.new(board)
      @breaker = Human.new(board)
    when '2'
      @maker = Human.new(board)
      @breaker = Computer.new(board)
    end
  end

  def prompt_for_play_again
    puts "Play again? 'y' = yes, any other key = no"
  end

  def set_up
    choice = nil
    board.clear

    until valid_menu_choice?(choice)
      show_invalid_menu_choice_message if choice

      show_menu
      choice = gets.chomp.strip.downcase
    end

    if choice == '3'
      puts 'Thanks for playing, goodbye :)!'
    else
      request_mastercode(choice)
    end
  end

  def request_mastercode(choice)
    input = nil
    init_players(choice)
    Guess.u_values_for_all_guesses.clear

    until valid_code?(input.to_s) || input == 'q'
      show_invalid_code_message(input) if input

      prompt_for_mastercode if maker.instance_of?(Human)
      input = maker.choose_mastercode
    end

    if valid_code?(input)
      board.store_mastercode(input)
      game_loop
    else
      play_again_or_end_game
    end
  end

  def handle_guess(input)
    if valid_code?(input.map(&:value).join)
      board.store_guess_pegs(input)
      board.store_clue_pegs(clue)

      if breaker.instance_of?(Human)
        show_board
        show_clue
      end
    else
      show_invalid_code_message(input.map(&:value).join)
    end
  end

  def game_loop
    input = nil

    until correct_guess? || max_board_rows_reached? || input == 'q'
      sleep(1) if breaker.instance_of?(Computer)

      prompt_for_guess(board.current_row)
      input = breaker.guess_mastercode
      handle_guess(input) unless input == 'q'
    end

    if correct_guess?
      player = breaker.instance_of?(Computer) ? 'The computer' : 'You'
      puts "#{player} deciphered the mastercode!"
    elsif max_board_rows_reached?
      puts "The mastercode of #{board.mastercode} was not deciphered within 12 guesses"
    end

    play_again_or_end_game
  end

  def show_invalid_code_message(guess)
    puts "The code you entered - #{guess} was invalid. Please try again."
  end

  def prompt_for_mastercode
    puts 'Please enter a 4 digit mastercode'
    puts 'Each digit can be 1-6 and duplicates are allowed (e.g. 1223)'
    puts "'q' to quit"
  end

  def prompt_for_guess(current_row)
    message = "Row: #{current_row} #{'last row!' if current_row == 12}"
    message += '- Please enter a 4 digit number.'
    message += 'Each digit can be 1-6 and duplicates are allowed '
    message += "(e.g. #{board.mastercode})"

    puts message
    puts "'q' to quit"
  end

  def valid_code?(code)
    all_valid_numbers(code) && code.length == 4
  end

  def valid_menu_choice?(choice)
    ('1'..'3').include?(choice)
  end

  def colour_number_range
    (@min_colour_number.to_s..@max_colour_number.to_s)
  end

  def all_valid_numbers(code)
    code.split('').map do |element|
      colour_number_range.include?(element)
    end.all?(true)
  end

  def correct_guess?
    board.last_guess.join == board.mastercode
  end

  def max_board_rows_reached?
    board.guess_pegs.length == 13
  end

  def show_board
    board.show
  end

  def show_clue
    # p Clue.new(clue).format
    p clue
  end

  def guess_peg_matches_left?(guess_peg_value, mastercode_peg_value, count)
    pegs_equal = guess_peg_value == mastercode_peg_value
    count_positive = count.positive?
    pegs_equal && count_positive
  end

  def clue
    guess_pegs = board.guess_pegs.last
    mastercode_pegs = board.mastercode.split('')
    mastercode_tallies = mastercode_pegs.tally

    clue_pegs = %w[_ _ _ _]

    guess_pegs.map(&:value).each_with_index do |guess_peg_value, index|
      next unless mastercode_tallies.any? do |mastercode_peg_value, count|
                    guess_peg_matches_left?(guess_peg_value, mastercode_peg_value, count)
                  end

      if guess_peg_value == mastercode_pegs[index]
        clue_pegs[index] = 'x'
        mastercode_tallies[guess_peg_value] -= 1
      end

      if clue_pegs[index] == '_'
        clue_pegs[index] = 'o'
        mastercode_tallies[guess_peg_value] -= 1
      end
    end

    clue_pegs
  end
end
