# frozen_string_literal: true

# The Human class is responsible for representing a Human and how
# they create and guess a mastercode
class Human < Player
  def make_mastercode
    input_code
  end

  def break_mastercode
    input_code
  end

  private

  def input_code
    gets.chomp.strip.downcase
  end
end
