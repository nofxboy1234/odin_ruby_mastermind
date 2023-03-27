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

  def play(choice)
    init_players(choice)
    Guess.u_values_for_all_guesses.clear

    prompt_for_mastercode if maker.instance_of?(Human)
    mastercode = maker.choose_mastercode

    if valid_code?(mastercode)
      board.store_mastercode(mastercode)
      game_loop
    elsif mastercode == 'q'
      prompt_for_play_again
      if play_again?
        set_up
      else
        puts 'Thanks for playing, goodbye :)!'
      end
    else
      show_invalid_code_message(mastercode)
      play(choice)
    end
  end

  def show_invalid_menu_choice_message
    puts 'The menu choice you entered was invalid. Please try again.'
  end

  def set_up
    board.clear
    show_menu

    choice = gets.chomp.strip.downcase
    if valid_menu_choice?(choice)
      if choice == '3'
        puts 'Thanks for playing, goodbye :)!'
      else
        play(choice)
      end
    else
      show_invalid_menu_choice_message
      set_up
    end
  end

  def show_game_end_message
    puts 'Thanks for playing, goodbye :)!'
  end

  def init_players(choice)
    case choice
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

  def play_again?
    answer = gets.chomp.strip.downcase
    answer == 'y'
  end

  def game_loop
    guess_pegs = nil

    # until game_over?
    z = false
    until z == true
      sleep(1) if breaker.instance_of?(Computer)
      prompt_for_guess(board.current_row)
      guess_pegs = breaker.guess_mastercode

      if valid_code?(guess_pegs.map(&:value).join)
        board.store_guess_pegs(guess_pegs)
        board.store_clue_pegs(clue)

        if breaker.instance_of?(Human)
          show_board
          show_clue
        end
      elsif guess_pegs == 'q'
        break
      else
        show_invalid_code_message(guess_pegs.map(&:value).join)
      end
    end

    if correct_guess?
      player = breaker.instance_of?(Computer) ? 'The computer' : 'You'
      puts "#{player} deciphered the mastercode!"
    else
      puts "The mastercode of #{board.mastercode} was not deciphered within 12 guesses"
    end

    prompt_for_play_again
    if play_again?
      set_up
    else
      puts 'Thanks for playing, goodbye :)!'
    end
  end

  def show_invalid_code_message(guess)
    puts "The code you entered - #{guess} was invalid. Please try again."
  end

  def game_over?
    # return unless board.guess_pegs

    correct_guess? || board.guess_pegs.length == 13
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
    # return unless board.guess_pegs

    board.last_guess.join == board.mastercode
  end

  def show_board
    board.show
  end

  def show_clue
    # p format_clue(clue)
    p clue
  end

  def guess_peg_matches_left?(guess_peg, mastercode_peg, count)
    guess_peg == mastercode_peg && count.positive?
  end

  def clue
    # return unless board.guess_pegs

    guess_pegs = board.guess_pegs.last
    mastercode_pegs = board.mastercode.split('')
    # mastercode_tallies = mastercode_pegs.tally
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
    end

    guess_pegs.map(&:value).each_with_index do |guess_peg_value, index|
      next unless mastercode_tallies.any? do |mastercode_peg_value, count|
                    guess_peg_matches_left?(guess_peg_value, mastercode_peg_value, count)
                  end

      if clue_pegs[index] == '_'
        clue_pegs[index] = 'o'
        mastercode_tallies[guess_peg_value] -= 1
      end
    end

    clue_pegs
  end
end
