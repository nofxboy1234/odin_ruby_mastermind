# frozen_string_literal: true

# The Human class is responsible for guessing and choosing a mastercode
class Human < Player
  def choose_mastercode
    gets.chomp.strip.downcase.split('')
  end

  def guess_mastercode
    input = gets.chomp.strip.downcase.split('')
  end
end
