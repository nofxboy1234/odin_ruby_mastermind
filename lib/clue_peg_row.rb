# frozen_string_literal: true

# CluePegRow is responsible for storing clue pegs
class CluePegRow
  attr_reader :value

  def initialize(clue_array)
    @value = create_clue_pegs(clue_array)
  end

  def to_s
    value.map(&:value).join
  end

  def all_u?
    value.all?('_')
  end

  def any_o?
    value.any?('o')
  end

  def all_x?
    value.all?('x')
  end

  def format
    value.delete('_')
    value.sort { |element, _next_element| element == 'x' ? -1 : 1 }
  end

  def no_match_pegs
    value.select { |clue_peg| clue_peg.no_match? }
  end

  private

  def create_clue_pegs(clue_array)
    return if clue_array.nil?

    clue_array.map do |value, index|
      CluePeg.new(value)
    end
  end
end
