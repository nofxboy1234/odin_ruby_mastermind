# frozen_string_literal: true

# CodePegRow is responsible for storing clue pegs
class CodePegRow
  attr_reader :value

  def initialize(code_array)
    @value = create_code_pegs(code_array)
  end

  def valid?
    return false if value.nil?

    all_pegs_valid? && correct_size?
  end

  def to_s
    value.map(&:value).join
  end

  def nil?
    value.nil?
  end

  private

  def create_code_pegs(code_array)
    return if code_array.nil?

    ids = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D' }

    code_array.map.with_index do |value, index|
      clue = CluePeg.new('_')
      id = ids[index]
      CodePeg.new(value, clue, id)
    end
  end

  def all_pegs_valid?
    value.all? { |peg| peg.valid?}
  end

  def correct_size?
    value.size == 4
  end
end
