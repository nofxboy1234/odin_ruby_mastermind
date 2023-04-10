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

# The Main class is responsible for the main flow of the game
class Main
  attr_reader :end_game, :main_menu, :game, :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new

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
      @game = Game.new(computer, human)
      game_main_loop
    when '2'
      @game = Game.new(human, computer)
      game_main_loop
    when '3'
      @end_game = true
    end
  end

  def game_main_loop
    game.main_loop
  end
end

Main.new
