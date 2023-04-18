# frozen_string_literal: true

# The CodeRowMenu class is responsible for displaying menus in the game
class CodeRowMenu
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def main_loop
    until valid_code?
      show
      choose
    end
  end

  def code
    @code ||= NullCodeRow.new
  end

  private

  def show
    puts 'Please enter a 4 digit code'
    puts 'Each digit can be 1-6 and duplicates are allowed'
  end

  def choose
    @code = CodeRow.new(player.code)

    @code.store_empty_code_numbers(player.board.all_empty_code_peg_numbers)

    show_invalid_message unless valid_code?
  end

  def show_invalid_message
    puts "The code you entered (#{code}) was invalid. Please try again."
  end

  def valid_code?
    code.valid?
  end
end
