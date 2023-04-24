# frozen_string_literal: true

# The CodeRowMenu class is responsible for displaying menus in the game
class CodeRowMenu
  attr_reader :player, :code

  def initialize(player)
    @player = player

    @code = NullCodeRow.new
  end

  def player_is_a_human?
    if player.is_a?(CodeMaker)
      player.maker.is_a?(Human)
    elsif player.is_a?(CodeBreaker)
      player.breaker.is_a?(Human)
    else
      false
    end
  end

  def main_loop
    until valid_code?
      show if player_is_a_human?
      choose
    end
  end

  private

  def show
    puts 'Please enter a 4 digit code'
    puts 'Each digit can be 1-6 and duplicates are allowed'
  end

  def choose
    @code = CodeRow.new(player.code)
    # code.store_empty_code_numbers(player.board.all_empty_code_peg_numbers)

    show_invalid_message unless valid_code?
  end

  def show_invalid_message
    puts "The code you entered (#{code}) was invalid. Please try again."
  end

  def valid_code?
    code.valid?
  end
end
