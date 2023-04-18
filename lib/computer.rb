# frozen_string_literal: true

# The Computer class is responsible for representing a Computer and how
# they create and guess a mastercode
class Computer < Player
  def make_mastercode
    random_code.join
    '3535'

    # gets.chomp.strip.downcase
  end

  def break_mastercode
    if board.code_rows.empty?
      random_code.join
    else
      algorithm = MindReadAlgorithm.new(board)
      algorithm.run
    end
  end

  private

  def random_code
    (1..4).inject([]) { |random_numbers, _n| random_numbers << rand(1..6) }
  end
end
