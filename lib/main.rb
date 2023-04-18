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
require_relative 'player'
require_relative 'human'
require_relative 'computer'
require_relative 'code_maker'
require_relative 'code_breaker'
require_relative 'tally'
require_relative 'mind_read_algorithm'

# The Main class is responsible for the main flow of the game
class Main
  attr_reader :main_menu

  def initialize
    @main_menu = MainMenu.new(1, 3)

    main_loop
  end

  private

  def end_game?
    main_menu.choice.number == '3'
  end

  def main_loop
    until end_game?
      main_menu.main_loop

      run_game unless end_game?
    end
    show_end_game_message
  end

  def show_end_game_message
    puts 'Thanks for playing, goodbye :)!'
  end

  def run_game
    game = Game.new(main_menu.choice.number)
    game.main_loop
  end
end

Main.new
