# frozen_string_literal: true

require 'pry-byebug'

require_relative 'menu'
require_relative 'game'

# The Main class is responsible for the main flow of the game
class Main
  attr_reader :end_game, :main_menu, :game

  def initialize
    @main_menu = Menu.new
    @game = Game.new

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
      puts 'Play as the CodeBreaker'
      game.main_loop
    when '2'
      puts 'Play as the CodeMaker'
    when '3'
      @end_game = true
    end
  end
end

Main.new
