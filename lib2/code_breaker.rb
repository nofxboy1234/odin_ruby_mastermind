# frozen_string_literal: true

# The CodeBreaker class is responsible for representing a CodeBreaker and how
# they create and guess a mastercode
class CodeBreaker
  attr_reader :breaker

  def initialize(breaker)
    @breaker = breaker
  end

  def code
    breaker.break_mastercode
  end
end
