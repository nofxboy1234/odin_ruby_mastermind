require 'pry-byebug'

class CodeBreaker
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def guess(code)
    place_pegs(code)
  end

  private

  def place_pegs(code)
    board.store_guess_pegs(code)
  end
end

class CodeMaker
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def create_mastercode(code)
    place_pegs(code)
  end

  private

  def place_pegs(code)
    board.store_code_pegs(code)
  end
end

class Board
  attr_accessor :code_pegs
  attr_reader :guess_pegs

  def initialize
    @code_pegs = nil
    @guess_pegs = []
  end

  def store_guess_pegs(pegs)
    guess_pegs << pegs
    # p "guess_pegs: #{guess_pegs}"
  end

  def store_code_pegs(pegs)
    self.code_pegs = pegs
  end
end

class Game
  attr_reader :board
  attr_accessor :maker, :breaker

  def initialize(board, maker, breaker)
    @board = board
    @maker = maker
    @breaker = breaker
    game_loop
  end

  private

  def random_code
    (1..4).inject([]) { |random4, _n| random4 << rand(1..6) }
  end

  def player_is_breaker
    mastercode = random_code.join
    # mastercode = '6544'
    maker.create_mastercode(mastercode)

    guess = nil

    until guess == 'q'
      break if board.guess_pegs.length == 12

      current_row = board.guess_pegs.length + 1

      puts "Row: #{current_row} #{if current_row == 12
                                    'last row!'
                                  end} - Please enter a 4 digit number. Each digit can be 1-6 (e.g. #{mastercode}): "
      puts "'q' to quit"
      guess = gets.chomp.strip.downcase
      # binding.pry
      next unless valid_code?(guess)

      breaker.guess(guess)
      break if correct_guess?
    end

    if correct_guess?(guess)
      puts 'You deciphered the mastercode!'
    else
      puts 'You were unable to decipher the code in 12 guesses'
      puts "The mastercode was #{mastercode}"
    end

    puts "Play again? 'y' = yes, any other key = no"
    answer = gets.chomp.strip.downcase
    if answer == 'y'
      board.guess_pegs.clear
      game_loop
    else
      puts 'Thanks for playing, goodbye :)!'
    end
  end

  def player_is_maker
    puts 'Please enter a 4 digit mastercode for the computer to crack.'
    puts 'Each digit can be 1-6 and duplicates are allowed (e.g. 1223)'
    mastercode = gets.chomp.strip.downcase
    # mastercode = '6544'
    maker.create_mastercode(mastercode)

    guess = nil

    until guess == 'q'
      sleep(1)

      break if board.guess_pegs.length == 12

      current_row = board.guess_pegs.length + 1

      puts "Row: #{current_row} #{if current_row == 12
                                    'last row!'
                                  end} - Please enter a 4 digit number. Each digit can be 1-6 and duplicates are allowed (e.g. #{mastercode}): "
      puts "'q' to quit"
      guess = random_code.join
      # binding.pry
      next unless valid_code?(guess)

      breaker.guess(guess)
      break if correct_guess?
    end

    if correct_guess?(guess)
      puts 'The computer deciphered the mastercode!'
    else
      puts 'The computer was unable to decipher the code in 12 guesses'
      puts "The mastercode was #{mastercode}"
    end

    game_loop
  end

  def game_loop
    puts 'Would you like to be the:'
    puts '1. Be the CodeBreaker'
    puts '2. Be the CodeMaker'
    puts '3. Quit'
    puts 'Enter "1", "2", or "3"'

    # binding.pry

    choice = gets.chomp.strip.downcase

    # if choice == '1'
    #   player_is_breaker
    # elsif choice == '2'
    #   player_is_maker
    # elsif choice == '3'
    #   puts 'Thanks for playing, goodbye :)!'
    # end

    case choice
    when '1'
      player_is_breaker
    when '2'
      player_is_maker
    when '3'
      puts 'Thanks for playing, goodbye :)!'
    end
  end

  def valid_code?(guess)
    all_numbers = guess.split('').map { |element| ('1'..'6').include?(element) }.all?(true)
    all_numbers && guess.length == 4
  end

  def correct_guess?(guess = nil)
    # binding.pry
    if board.guess_pegs.last == board.code_pegs
      true
    elsif guess == 'q'
      false
    else
      p board.code_pegs.split('')
      p board.guess_pegs.last.split('')
      p show_clue
      false
    end
  end

  def show_clue
    guess_pegs = board.guess_pegs.last.split('')
    code_pegs = board.code_pegs.split('')
    tallies = code_pegs.tally

    clue = %w[_ _ _ _]
    guess_pegs.each_with_index do |element, i|
      next unless tallies.include?(element)
      next if tallies[element].zero?

      if element == board.code_pegs[i]
        clue[i] = 'x'
        tallies[element] -= 1
      end
    end

    guess_pegs.each_with_index do |element, i|
      next unless tallies.include?(element)
      next if tallies[element].zero?

      if board.code_pegs.include?(element) && (clue[i] == '_')
        clue[i] = 'o'
        tallies[element] -= 1
      end
    end
    format_clue(clue)
    # clue
  end

  def format_clue(clue)
    clue.delete('_')
    clue.sort { |a, _b| a == 'x' ? -1 : 1 }
  end
end

board = Board.new
maker = CodeMaker.new(board)
breaker = CodeBreaker.new(board)

Game.new(board, maker, breaker)
