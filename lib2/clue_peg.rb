# frozen_string_literal: true

# The CluePeg class represents a clue peg used in the game
class CluePeg
  attr_reader :clue

  def initialize(clue)
    @clue = clue
  end

  def empty?
    clue == '_'
  end

  def partial?
    clue == 'o'
  end

  def match?
    clue == 'x'
  end
end
