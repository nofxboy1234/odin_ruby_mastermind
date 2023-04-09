# frozen_string_literal: true

# The CodeRow class is responsible for the mastercode in the game
class CodeRow
  attr_reader :pegs, :numbers

  def initialize(numbers)
    @numbers = numbers.split('')

    create_pegs
  end

  def create_pegs
    @pegs = numbers.map.with_index do |number, index|
      CodePeg.new(number, index, 1, 6)
    end
  end

  def valid?
    all_valid_pegs? && pegs_size_valid?
  end

  def to_s
    numbers.to_s
  end

  def join
    numbers.join
  end

  private

  def all_valid_pegs?
    pegs.all?(&:valid?)
  end

  def pegs_size_valid?
    pegs.size == 4
  end
end
