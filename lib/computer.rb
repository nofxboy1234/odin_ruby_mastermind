class Computer < Player
  attr_reader :clue, :guess

  def initialize(board)
    super
    @clue = nil
    @guess = nil
  end

  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    @guess = if clue.nil?
               random_code.join
             else
               p o_elements_with_index
               random_code.join
               #  retain_x_strategy
             end

    guess
  end

  def store_clue(clue)
    @clue = clue
  end

  private

  def retain_x_strategy
    # if ["o", "o", "o", "o"] then shuffle
    if clue == %w[o o o o]
      guess.shuffle
    else
      # ["1", "2", "3", "4"]

      # First guess
      # ["2", "2", "1", "6"]
      # ["_", "x", "o", "_"]

      # ["2", "2", "1", "6"]
      # ["2", "2", "1", "1"]*
      # ["2", "2", "3", "1"]
      # ["4", "2", "3", "1"]
      # ["o", "x", "x", "o"]

      # ["4", "2", "3", "1"]
      # ["1", "2", "3", "4"]

      # Replace 1 or more '_' values with an 'o' value (move 'o' value)
      ### if no more '_', swap 'o' value with another 'o' value until all 'o' values have been swapped
      # Replace each 'o' value with rand(1..6) value (not '_' or original 'o' value)
      # Replace each REMAINING (not replaced by an 'o' value) '_' value with a rand(1..6) (not original '_')

      move_o_values
    end
  end

  def o_elements_with_index
    # binding.pry
    guess_with_index = []
    guess.split('').each_with_index do |element, i|
      guess_with_index << [element, i, clue[i]]
    end
    # end.select { |element| element[2] == 'o' }

    guess_with_index
    # guess_with_clue.select { |element| element[1] == 'o' }
  end

  # def underscore_elements_with_index
  #   guess_with_clue = []
  #   guess.split('').each_with_index { |element, i| guess_with_clue << [element, i] if clue[i] == 'o' }
  #   guess_with_clue.select { |element| element[1] == 'o' }
  # end

  # def move_o_values
  #   # Get index of all '_'
  #   o_elements = all_o_elements

  #   guess_array = guess.split('')
  #   guess_array.map |element| do
  #     if element == '_'
  #       #
  #     end
  #   end
  #   guess.gsub
  # end

  def tmp
    # guess_with_clue = []
    # guess.split('').each_with_index { |element, i| guess_with_clue << [element, clue[i]] }
    # o_elements = guess_with_clue.select { |element| element[1] == 'o' }
    # guess.gsub('_')
  end

  def random_code
    (1..4).inject([]) { |random4, _n| random4 << rand(1..6) }
  end
end
