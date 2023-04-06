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

# The Main class is responsible for the main flow of the game
class Main
  attr_reader :end_game, :main_menu, :game

  def initialize
    main_loop
  end

  private

  def main_loop
    until end_game
      @main_menu = MainMenu.new(1, 3)
      main_menu.main_loop

      run_menu_choice
    end
    show_end_game_message
  end

  def show_end_game_message
    puts 'Thanks for playing, goodbye :)!'
  end

  def run_menu_choice
    case main_menu.choice.number
    when '1'
      @game = Game.new
      game.main_loop
    when '2'
      puts 'Play as the CodeMaker'
    when '3'
      @end_game = true
    end
  end
end

Main.new
