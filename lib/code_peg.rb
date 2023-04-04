# frozen_string_literal: true

# GuessPeg is responsible for storing peg attributes
class CodePeg
  attr_reader :value, :clue, :id

  def initialize(value, clue, id)
    @min_colour_number = 1
    @max_colour_number = 6

    @value = value
    @clue = clue
    @id = id
  end

  def value=(value)
    @value = value
  end

  def clue=(value)
    @clue = value
  end

  def id=(value)
    @id = value
  end

  def valid?
    colour_number_range.include?(value)
  end

  private

  attr_reader :min_colour_number, :max_colour_number

  def colour_number_range
    (min_colour_number.to_s..max_colour_number.to_s)
  end
end
