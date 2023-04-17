# frozen_string_literal: true

# The RangeNumber class is responsible for a number assigned to a CodePeg.
class RangeNumber
  attr_reader :number

  def initialize(number, min, max)
    @min = min
    @max = max

    @number = number
  end

  def valid?
    range.include?(number)
  end

  def update(number)
    @number = number
  end

  private

  def range
    (@min.to_s..@max.to_s)
  end
end
