# frozen_string_literal: true

# The Menu class is responsible for displaying menus in the game
class Menu
  def initialize
    ##
  end

  def show
    puts "Welcome to Mastermind!\n"
    puts "Please choose an option by entering '1', '2', or '3':"
    puts '1. Play as the CodeBreaker'
    puts '2. Play as the CodeMaker'
    puts '3. Quit'
  end
end
