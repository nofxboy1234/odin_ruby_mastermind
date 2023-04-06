# frozen_string_literal: true

# The Clue class is responsible for representing
# a sequence of clue pegs and checking for specific combinations
# of pegs.
class ClueOld
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def all_u?
    value.all?('_')
  end

  def any_o?
    value.any?('o')
  end

  def all_x?
    value.all?('x')
  end

  def format
    value.delete('_')
    value.sort { |element, _next_element| element == 'x' ? -1 : 1 }
  end
end
