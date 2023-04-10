# frozen_string_literal: true

require 'pry-byebug'

require_relative 'main_menu'
require_relative 'game'
require_relative 'code_row_menu'
require_relative 'code_row'
require_relative 'code_peg'
require_relative 'range_number'
require_relative 'board'
require_relative 'clue_peg'
require_relative 'clue_row'
require_relative 'null_code_row'
require_relative 'human'
require_relative 'computer'
require_relative 'code_maker'
require_relative 'code_breaker'

# The Main class is responsible for the main flow of the game
class Main
  attr_reader :end_game, :maker, :breaker

  def initialize
    main_loop
  end

  private

  def main_loop
    until end_game
      main_menu = MainMenu.new(1, 3)

      run_menu_choice(main_menu)
      run_game unless main_menu.choice.number == '3'
    end
    show_end_game_message
  end

  def show_end_game_message
    puts 'Thanks for playing, goodbye :)!'
  end

  def run_menu_choice(main_menu)
    case main_menu.choice.number
    when '1'
      @maker = CodeMaker.new(Computer.new)
      @breaker = CodeBreaker.new(Human.new)
    when '2'
      @maker = CodeMaker.new(Human.new)
      @breaker = CodeBreaker.new(Computer.new)
    when '3'
      @end_game = true
    end
  end

  def run_game
    Game.new(maker, breaker)
  end
end

Main.new
