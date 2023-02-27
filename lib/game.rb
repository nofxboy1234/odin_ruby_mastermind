class Game
  attr_reader :board, :maker, :breaker

  def initialize
    @min_colour_number = 1
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
    prompt_for_mastercode if maker.instance_of?(Human)
    mastercode = maker.choose_mastercode

    if valid_code?(mastercode)
      board.store_mastercode_pegs(mastercode)
      game_loop
    elsif mastercode == 'q'
      set_up
    else
      show_invalid_code_message
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
    guess = nil

    until game_over?(guess)
      sleep(1) if breaker.instance_of?(Computer)

      prompt_for_guess(board.current_row)
      guess = breaker.guess_mastercode

      if valid_code?(guess)
        board.store_guess_pegs(guess)
        show_board
        show_clue
      elsif guess == 'q'
        break
      else
        show_invalid_code_message
      end
    end

    if correct_guess?
      player = breaker.instance_of?(Computer) ? 'The computer' : 'You'
      puts "#{player} deciphered the mastercode!"
    else
      puts "The mastercode of #{board.mastercode_pegs} was not deciphered within 12 guesses"
    end

    prompt_for_play_again
    if play_again?
      set_up
    else
      puts 'Thanks for playing, goodbye :)!'
    end
  end

  def show_invalid_code_message
    puts 'The code you entered was invalid. Please try again.'
  end

  def game_over?(guess)
    return unless guess

    correct_guess? || board.guess_pegs.length == 12
  end

  def prompt_for_mastercode
    puts 'Please enter a 4 digit mastercode'
    puts 'Each digit can be 1-6 and duplicates are allowed (e.g. 1223)'
    puts "'q' to quit"
  end

  def prompt_for_guess(current_row)
    puts "Row: #{current_row} #{if current_row == 12
                                  'last row!'
                                end} - Please enter a 4 digit number. Each digit can be 1-6 and duplicates are allowed (e.g. #{board.mastercode_pegs}): "
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
    code.split('').map { |element| colour_number_range.include?(element) }.all?(true)
  end

  def correct_guess?
    board.guess_pegs.last == board.mastercode_pegs
  end

  def show_board
    board.show
  end

  def show_clue
    # p format_clue(clue)
    p clue
  end

  def clue
    guess_pegs = board.guess_pegs.last.split('')
    code_pegs = board.mastercode_pegs.split('')
    tallies = code_pegs.tally

    clue_pegs = %w[_ _ _ _]
    guess_pegs.each_with_index do |element, i|
      next unless tallies.include?(element)
      next if tallies[element].zero?

      if element == board.mastercode_pegs[i]
        clue_pegs[i] = 'x'
        tallies[element] -= 1
      end
    end

    guess_pegs.each_with_index do |element, i|
      next unless tallies.include?(element)
      next if tallies[element].zero?

      if board.mastercode_pegs.include?(element) && (clue_pegs[i] == '_')
        clue_pegs[i] = 'o'
        tallies[element] -= 1
      end
    end
    clue_pegs
  end

  def format_clue(clue)
    clue.delete('_')
    clue.sort { |a, _b| a == 'x' ? -1 : 1 }
  end
end
