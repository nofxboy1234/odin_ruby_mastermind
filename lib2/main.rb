# frozen_string_literal: true

require 'pry-byebug'

# The Main class is responsible for the main flow of the game
class Main
  attr_reader :input

  def initialize
    @input = nil

    main_loop
  end

  def main_loop
    show_main_menu
    choose_menu_option
    puts 'play game until game over'
    puts 'show end game message'
  end

  def show_main_menu
    puts "Welcome to Mastermind!\n"
    puts "Please choose an option by entering '1', '2', or '3':"
    puts '1. Play as the CodeBreaker'
    puts '2. Play as the CodeMaker'
    puts '3. Quit'
  end

  def choose_menu_option
    until valid_menu_choice?
      show_invalid_menu_choice_message if input

      @input = gets.chomp.strip.downcase
    end

    puts 'Valid menu option chosen!'
  end

  def valid_menu_choice?
    ('1'..'3').include?(input)
  end

  def show_invalid_menu_choice_message
    puts 'The menu choice you entered was invalid. Please try again.'
  end
end

Main.new
