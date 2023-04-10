# frozen_string_literal: true

# The CodeRowMenu class is responsible for displaying menus in the game
class CodeRowMenu
  attr_reader :player, :role

  def initialize(player, role)
    @player = player
    @role = role
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
    if role == 'maker'
      @code = CodeRow.new(player.create_mastercode)
    elsif role == 'breaker'
      @code = CodeRow.new(player.guess_mastercode)
    end
    show_invalid_message unless valid_code?
  end

  def show_invalid_message
    puts 'The code you entered was invalid. Please try again.'
  end

  def valid_code?
    code.valid?
  end
end
