# frozen_string_literal: true

# The Tally class is responsible for the mastercode in the game
class Tally
  private

  attr_reader :counts

  public

  def initialize(counts)
    @counts = counts
  end

  def count_positive?(number)
    counts.keys.any?(number) &&
      counts[number].positive?
  end

  def decrement(number)
    counts[number] -= 1
  end
end
