class Computer < Player
  def initialize(board)
    super
    @all_valid_clue_permutations = all_valid_clue_permutations
    @count = @all_valid_clue_permutations.size
  end

  def choose_mastercode
    random_code.join
  end

  def random_code
    (1..4).inject([]) { |random4, _n| random4 << rand(1..6) }
  end

  def rotate_and_decrement
    @all_valid_clue_permutations.rotate!
    @count -= 1
  end

  def test_specific_clue
    peg0 = GuessPeg.new('4', 'o')
    peg1 = GuessPeg.new('2', '_')
    peg2 = GuessPeg.new('3', 'o')
    peg3 = GuessPeg.new('4', 'o')
    [] << peg0 << peg1 << peg2 << peg3
  end

  def test_all_clues
    if @count.positive?
      rotate_and_decrement
      Guess.new(test_guess_peg_row).guess_pegs
    else
      Guess.new(all_x).guess_pegs
    end
  end

  def guess_mastercode
    # Guess.u_values_for_all_guesses.clear
    # Guess.new(test_specific_clue).guess_pegs

    # Guess.u_values_for_all_guesses.clear
    # test_all_clues

    Guess.new(board.guess_pegs.last).guess_pegs
  end

  def test_guess_peg_row
    peg_row = []
    @all_valid_clue_permutations.first.each_with_index do |clue, index|
      guess_peg = GuessPeg.new(index.succ.to_s, clue)
      peg_row << guess_peg
    end
    peg_row
  end

  def temp
    a = %w[o o x x]
    a.permutation(4).to_a.uniq
    a.repeated_permutation(4).to_a.uniq # reject illegal clues e.g. oxxx
  end

  def total_different_patterns_in_mastermind
    (1..6).to_a.repeated_permutation(4).to_a.size # 1296
  end

  def all_o_permutations
    # 24
    [1, 2, 3, 4].permutation(4).to_a.size
  end

  def all_x
    peg0 = GuessPeg.new('1', 'x')
    peg1 = GuessPeg.new('2', 'x')
    peg2 = GuessPeg.new('3', 'x')
    peg3 = GuessPeg.new('4', 'x')
    [] << peg0 << peg1 << peg2 << peg3
  end

  def all_valid_clue_permutations
    a = %w[_ o x].repeated_permutation(4).to_a.uniq
    b = %w[o x x x].permutation(4).to_a.uniq
    c = [%w[x x x x]]
    a.difference(b, c)
  end
end
