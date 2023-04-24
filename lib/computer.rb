# frozen_string_literal: true

# The Computer class is responsible for representing a Computer and how
# they create and guess a mastercode
class Computer < Player
  def make_mastercode
    random_code.join
  end

  def break_mastercode
    # sleep(1)

    if board.code_rows.empty?
      # '3363'
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
