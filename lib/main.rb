require 'pry-byebug'

require_relative 'player'
require_relative 'codebreaker'
require_relative 'codemaker'
require_relative 'board'
require_relative 'game'

board = Board.new
maker = CodeMaker.new(board)
breaker = CodeBreaker.new(board)

Game.new(board, maker, breaker)
