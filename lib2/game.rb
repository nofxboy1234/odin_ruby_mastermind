# frozen_string_literal: true

# The Game class is responsible for the mastercode in the game
class Game
  attr_reader :stop_playing

  def initialize
    # no op.
  end

  def main_loop
    @stop_playing = false
    until stop_playing
      play
      @stop_playing = true
    end
  end

  def play
    guess_secret
    show_board
  end

  def guess_secret
    puts 'guess_secret'
  end

  def show_board
    puts 'show_board'
  end
end
