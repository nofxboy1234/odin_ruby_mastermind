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
      puts 'play game'
      @stop_playing = true
    end
  end
end
