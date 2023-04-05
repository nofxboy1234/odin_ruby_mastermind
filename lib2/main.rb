# frozen_string_literal: true

require 'pry-byebug'

# The Main class is responsible for the main flow of the game
class Main
  attr_reader :input, :end_game

  def initialize
    @input = nil

    main_loop
  end

  def main_loop
    until end_game
      show_main_menu
      choose_menu_option
      run_menu_choice
    end
    show_end_game_message
  end

  def show_main_menu
    puts "Welcome to Mastermind!\n"
    puts "Please choose an option by entering '1', '2', or '3':"
    puts '1. Play as the CodeBreaker'
    puts '2. Play as the CodeMaker'
    puts '3. Quit'
  end

  def choose_menu_option
    @input = gets.chomp.strip.downcase
  end

  def show_invalid_menu_choice_message
    puts 'The menu choice you entered was invalid. Please try again.'
  end

  def run_menu_choice
    case input
    when '1'
      puts 'You chose 1'
    when '2'
      puts 'You chose 2'
    when '3'
      @end_game = true
    else
      show_invalid_menu_choice_message
    end
  end

  def show_end_game_message
    puts 'Thanks for playing, goodbye :)!'
  end
end

Main.new
