# frozen_string_literal: true

# The CodeRow class is responsible for the mastercode in the game
class CodeRow
  attr_reader :pegs

  def initialize(numbers = '0000')
    @pegs = numbers.split('').map.with_index do |number, index|
      CodePeg.new(number, index)
    end
  end

  def valid?
    all_valid_pegs? && pegs_size_valid?
  end

  def all_valid_pegs?
    pegs.all?(&:valid?)
  end

  def pegs_size_valid?
    pegs.size == 4
  end

  def peg_numbers
    pegs.map(&:number).map(&:number)
  end

  def to_s
    peg_numbers.to_s
  end

  def join
    peg_numbers.join
  end
end
