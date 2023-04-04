# frozen_string_literal: true

# GuessPeg is responsible for storing peg attributes
class CodePeg
  attr_reader :value, :clue, :id

  def initialize(value = '', clue = '_')
    @value = value
    @clue = clue
    @id = nil
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
end
