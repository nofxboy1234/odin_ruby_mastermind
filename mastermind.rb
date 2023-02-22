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

  def game_loop
    mastercode = '3223'
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
      next unless valid_guess?(guess)

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

  def valid_guess?(guess)
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
      # p show_clue.join
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

      tallies[element] -= 1
      if element == board.code_pegs[i]
        clue[i] = 'x'
      elsif board.code_pegs.include?(element)
        clue[i] = 'o'
      end
    end
    clue
  end
end

board = Board.new
maker = CodeMaker.new(board)
breaker = CodeBreaker.new(board)

Game.new(board, maker, breaker)
