# frozen_string_literal: true

# The RangeNumber class is responsible for a number assigned to a CodePeg.
class RangeNumber
  attr_reader :number

  def initialize(number)
    @min = 1
    @max = 6

    @number = number
  end

  def valid?
    range.include?(number)
  end

  def range
    (@min.to_s..@max.to_s)
  end
end
