# frozen_string_literal: true

# The MainMenu class is responsible for displaying menus in the game
class MainMenu
  attr_reader :choice

  def main_loop
    @choice = RangeNumber.new('0', 1, 2)
    until valid_choice?
      show
      choose
    end
  end

  def show
    puts "Welcome to Mastermind!\n"
    puts "Please choose an option by entering '1', '2', or '3':"
    puts '1. Play as the CodeBreaker'
    puts '2. Play as the CodeMaker'
    puts '3. Quit'
  end

  def choose
    @choice = RangeNumber.new(gets.chomp.strip.downcase, 1, 3)
    show_invalid_message unless valid_choice?
  end

  def show_invalid_message
    puts 'The menu choice you entered was invalid. Please try again.'
  end

  def valid_choice?
    choice.valid?
  end
end
