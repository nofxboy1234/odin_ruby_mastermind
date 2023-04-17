# frozen_string_literal: true

# The Computer class is responsible for representing a Computer and how
# they create and guess a mastercode
class Computer
  private

  attr_reader :board

  public

  def initialize(board)
    @board = board
  end

  def make_mastercode
    random_code.join
    '3535'
  end

  def break_mastercode
    board

    random_code.join
  end

  private

  def random_code
    (1..4).inject([]) { |random_numbers, _n| random_numbers << rand(1..6) }
  end
end
