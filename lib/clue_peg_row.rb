# frozen_string_literal: true

# CluePegRow is responsible for storing clue pegs
class CluePegRow
  attr_reader :value

  def initialize(value = '')
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