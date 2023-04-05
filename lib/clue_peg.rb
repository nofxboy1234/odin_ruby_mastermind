# frozen_string_literal: true

# CluePeg is responsible for storing peg attributes
class CluePeg
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def value=(value)
    @value = value
  end

  def exact_match?
    value == 'x'
  end

  def partial_match?
    value == 'o'
  end

  def no_match?
    value == '_'
  end
end
