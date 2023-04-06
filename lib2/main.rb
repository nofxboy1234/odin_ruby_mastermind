# frozen_string_literal: true

require 'pry-byebug'

require_relative 'main_menu'
require_relative 'game'
require_relative 'code_row_menu'
require_relative 'code_row'
require_relative 'code_peg'
require_relative 'colour_number'
require_relative 'board'

# The Main class is responsible for the main flow of the game
class Main
  attr_reader :end_game, :main_menu, :game, :secret_row_menu, :board

  def initialize
    @main_menu = MainMenu.new
    @game = Game.new
    @secret_row_menu = CodeRowMenu.new

    main_loop
  end

  def main_loop
    until end_game
      main_menu.main_loop
      run_menu_choice
    end
    show_end_game_message
  end

  def show_end_game_message
    puts 'Thanks for playing, goodbye :)!'
  end

  def run_menu_choice
    case main_menu.choice
    when '1'
      secret_row_menu.main_loop
      game.main_loop(secret_row_menu)
    when '2'
      puts 'Play as the CodeMaker'
    when '3'
      @end_game = true
    end
  end
end

Main.new