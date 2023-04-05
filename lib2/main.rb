# frozen_string_literal: true

require 'pry-byebug'

# The Main class is responsible for the main flow of the game
class Main
  def initialize
    main_loop
  end

  def main_loop
    puts 'show main menu'
    puts 'play game until game over'
    puts 'show end game message'

    # @end_game = false
    # @is_game_over = false

    # until end_game
    # set_up
    # input = show_main_menu
    # break unless play_game?(input)

    # guess_loop

    # @end_game = play_again? ? false : true
    # @is_game_over = false
    # end

    # show_game_end_message
  end
end

Main.new
