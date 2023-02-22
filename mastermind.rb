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
    # binding.pry
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
    # binding.pry
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

  def game_loop
    # binding.pry
    maker.create_mastercode('1234')

    guess = nil

    until guess == 'q'
      puts 'Please enter a 4 digit number. Each digit can be 1-6 (e.g. 1346): '
      guess = gets.chomp.strip
      breaker.guess(guess)
      correct_guess?
    end
  end

  def correct_guess?
    if board.guess_pegs.last == board.code_pegs
      puts 'You deciphered the mastercode!'
    else
      puts show_clue.join
    end
  end

  private

  def show_clue
    clue = []
    board.guess_pegs.last.split('').each_with_index do |element, i|
      if element == board.code_pegs[i]
        clue << 'x'
      elsif board.code_pegs.include?(element)
        clue << 'o'
      end
    end
    clue
  end
end

board = Board.new
maker = CodeMaker.new(board)
breaker = CodeBreaker.new(board)

Game.new(board, maker, breaker)
