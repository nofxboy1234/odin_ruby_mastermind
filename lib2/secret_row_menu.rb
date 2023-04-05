# frozen_string_literal: true

# The SecretRowMenu class is responsible for displaying menus in the game
class SecretRowMenu
  attr_reader :secret_row

  def initialize
    ##
  end

  def main_loop
    @secret_row = SecretRow.new
    until valid_choice?
      show
      choose
    end
  end

  def show
    puts 'Please enter a 4 digit mastercode'
    puts 'Each digit can be 1-6 and duplicates are allowed (e.g. 1223)'
    puts "'q' to quit"
  end

  def choose
    @secret_row = SecretRow.new(gets.chomp.strip.downcase)
    show_invalid_message unless valid_choice?
  end

  def show_invalid_message
    puts 'The secret code you entered was invalid. Please try again.'
  end

  def valid_choice?
    secret_row.valid?
  end
end
