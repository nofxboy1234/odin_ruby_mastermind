require 'pry-byebug'

class CodeBreaker
  attr_reader :board, :game

  def initialize(board, game)
    @board = board
    @game = game
  end

  def guess(code)
    place_pegs(code)
    correct_guess?
  end

  private

  def place_pegs(code)
    # binding.pry
    board.place_guess_pegs(code)
  end

  def correct_guess?
    game.correct_guess?
  end
end

class Board
  attr_accessor :code_pegs

  attr_reader :guess_pegs

  def initialize
    @guess_pegs = []
  end

  def place_guess_pegs(pegs)
    guess_pegs << pegs
  end
end

class Game
  attr_reader :board
  attr_accessor :maker, :breaker

  def initialize
    @board = Board.new
    @maker = CodeMaker.new(board)
    @maker.create_master_code('1234')
    @breaker = CodeBreaker.new(board, self)
    # @breaker.guess(1234)
    game_loop
  end

  def game_loop
    guess = nil

    until guess == 'q'
      puts 'Please enter your guess: '
      guess = gets.chomp.strip
      breaker.guess(guess)
    end
  end

  def correct_guess?
    puts board.guess_pegs.last == board.code_pegs
  end
end

class CodeMaker
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def create_master_code(code)
    place_pegs(code)
  end

  private

  def place_pegs(code_pegs)
    board.code_pegs = code_pegs
  end
end

# binding.pry

Game.new
