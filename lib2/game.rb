# frozen_string_literal: true

# The Game class is responsible for the mastercode in the game
class Game
  attr_reader :stop_playing, :choice

  def initialize
    # no op.
  end

  def main_loop
    @choice = nil
    @stop_playing = false
    until stop_playing
      play
      @stop_playing = true
    end
  end

  def play
    ask_for_secret_code
    guess_secret
    show_board
  end

  def guess_secret
    @choice = gets.chomp.strip.downcase
  end

  def show_board
    puts 'show_board'
  end

  def ask_for_secret_code
    message = 'Please enter a 4 digit number.'
    message += 'Each digit can be 1-6 and duplicates are allowed '

    puts message
  end
end
