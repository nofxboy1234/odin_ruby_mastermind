# frozen_string_literal: true

require_relative 'colorable_string'

# The MainMenu class is responsible for displaying menus in the game
class MainMenu
  using ColorableString
  
  attr_reader :choice, :min_choice, :max_choice

  def initialize(min_choice, max_choice)
    initialize_choice
    @min_choice = min_choice
    @max_choice = max_choice

    # main_loop
  end

  def initialize_choice
    @choice = RangeNumber.new('0', min_choice, max_choice)
  end

  def main_loop
    initialize_choice

    until valid_choice?
      show
      choose
    end
  end

  private

  def show
    puts "Welcome to Mastermind!\n".fg_color(:cyan)
    puts "Please choose an option by entering '1', '2', or '3':".fg_color(:green)
    puts '1. Play as the CodeBreaker'.fg_color(:orange)
    puts '2. Play as the CodeMaker'.fg_color(:yellow)
    puts '3. Quit'.fg_color(:pink)
  end

  def choose
    @choice = RangeNumber.new(gets.chomp.strip.downcase, min_choice, max_choice)
    show_invalid_message unless valid_choice?
  end

  def show_invalid_message
    puts "\nThe menu choice you entered was invalid. Please try again.\n".fg_color(:pink)
  end

  def valid_choice?
    choice.valid?
  end
end
