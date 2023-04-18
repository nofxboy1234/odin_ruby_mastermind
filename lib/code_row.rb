# frozen_string_literal: true

# The CodeRow class is responsible for the mastercode in the game
class CodeRow
  private

  attr_reader :tally

  public

  attr_reader :pegs, :numbers

  def initialize(numbers)
    @numbers = numbers.split('')
    initialize_tally

    create_pegs
    @empty_clue_numbers = []
    # Store empty clue numbers
  end

  def store_empty_code_numbers(empty_clue_numbers)
    @empty_clue_numbers = empty_clue_numbers
  end

  def initialize_tally
    @tally = Tally.new(@numbers.tally)
  end

  def decrement_tally(number)
    tally.decrement(number)
  end

  def tally_count_positive?(number)
    tally.count_positive?(number)
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

  def numbers_with_index
    numbers.each_with_index.map do |number, index|
      [number, index]
    end
  end

  private

  def all_valid_pegs?
    pegs.all?(&:valid?)
  end

  def pegs_size_valid?
    pegs.size == 4
  end
end
