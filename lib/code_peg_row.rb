# frozen_string_literal: true

# CodePegRow is responsible for storing clue pegs
class CodePegRow
  attr_reader :value

  def initialize(value = '')
    @value = value
    create_ids
  end

  private

  def create_ids
    value.each_with_index do |code_peg, index|
      ids = { 0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd' }
      code_peg.id = ids[index].upcase
    end
  end
end
