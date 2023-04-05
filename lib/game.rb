# frozen_string_literal: true

# The Game class is responsible for running the game loop and checking for
# a winner
class Game
  attr_reader :board, :maker, :breaker, :is_game_over, :end_game, :clue

  def initialize
    @board = Board.new

    main_loop
  end

  private

  def show_menu
    puts "Welcome to Mastermind!\n"
    puts "Please choose an option by entering '1', '2', or '3':"
    puts '1. Play as the CodeBreaker'
    puts '2. Play as the CodeMaker'
    puts '3. Quit'
  end

  def play_again?
    prompt_for_play_again
    answer = gets.chomp.strip.downcase

    answer == 'y'
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
    board.clear
    Guess.u_values_for_all_guesses.clear
  end

  def loop_conditions(continue_game = nil)
    @end_game = if continue_game
                  false
                else
                  play_again? ? false : true
                end
    @is_game_over = false
  end

  def guess_loop
    until is_game_over
      input_guess
      create_clue
      board.store_clue_pegs(CluePegRow.new(clue))

      board.show if breaker.instance_of?(Human)
      check_guess
    end
  end

  def main_loop
    loop_conditions(true)
    # binding.pry
    until end_game
      set_up
      input = show_main_menu
      break unless play_game?(input)

      # binding.pry
      input_mastercode
      guess_loop

      loop_conditions
    end

    show_game_end_message
  end

  def show_main_menu
    input = nil

    until valid_menu_choice?(input)
      show_invalid_menu_choice_message if input

      show_menu
      input = gets.chomp.strip.downcase
    end

    input
  end

  def play_game?(input)
    return false if input == '3'

    init_players(input)
    true
  end

  def input_mastercode
    code = CodePegRow.new(nil)

    until code.valid?
      show_invalid_code_message(code) unless code.nil?

      prompt_for_mastercode if maker.instance_of?(Human)
      code = CodePegRow.new(maker.choose_mastercode)
      # binding.pry
    end

    board.store_mastercode(code)
    # binding.pry
  end

  def player_turn
    prompt_for_guess(board.current_row)
    sleep(1) if breaker.instance_of?(Computer)
  end

  def input_guess
    code = CodePegRow.new(nil)

    until code.valid?
      show_invalid_code_message(code) unless code.nil?

      player_turn
      code = CodePegRow.new(breaker.guess_mastercode)
      # binding.pry
    end

    board.store_code_pegs(code)
  end

  def calculate_clue(guess_peg_value, mastercode_tallies, index)
    if guess_peg_value == board.mastercode.value[index]
      clue[index] = 'x'
      mastercode_tallies[guess_peg_value] -= 1
    end

    return unless clue[index] == '_'

    clue[index] = 'o'
    mastercode_tallies[guess_peg_value] -= 1
  end

  def any_guess_peg_matches_left?(guess_peg_value, mastercode_tallies)
    mastercode_tallies.any? do |mastercode_peg_value, count|
      pegs_equal = guess_peg_value == mastercode_peg_value
      count_positive = count.positive?
      pegs_equal && count_positive
    end
  end

  def create_clue
    mastercode_tallies = board.mastercode.value.map(&:value).tally

    @clue = %w[_ _ _ _]

    board.last_code_peg_row.value.map(&:value).each_with_index do |guess_peg_value, index|
      next unless any_guess_peg_matches_left?(guess_peg_value, mastercode_tallies)

      calculate_clue(guess_peg_value, mastercode_tallies, index)
    end
  end

  def check_guess
    if correct_guess?
      player = breaker.instance_of?(Computer) ? 'The computer' : 'You'
      puts "#{player} deciphered the mastercode!"
      @is_game_over = true
    elsif board.max_rows_reached?
      puts "The mastercode of #{board.mastercode} was not deciphered within 12 guesses"
      @is_game_over = true
    end
  end

  def show_invalid_code_message(code)
    puts "The code you entered - #{code} was invalid. Please try again."
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



  def valid_menu_choice?(choice)
    return false if choice.nil?

    ('1'..'3').include?(choice)
  end

  def correct_guess?
    board.code_pegs_match_mastercode?
  end
end
