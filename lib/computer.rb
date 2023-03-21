class Computer < Player
  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    # Guess.new(board.guess_pegs.last).guess_pegs

    Guess.new(all_o).guess_pegs
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

  # ["o", "o", "o", "o"].permutation(4).to_a.uniq.size == 1
  # [0, 1, 2, 3].permutation(4).to_a.uniq.size == 24
  def all_o
    peg0 = GuessPeg.new('1', 'o')
    peg1 = GuessPeg.new('2', 'o')
    peg2 = GuessPeg.new('3', 'o')
    peg3 = GuessPeg.new('4', 'o')
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_ooxx
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_oxox
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_oxxo
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_xoox
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_xoxo
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_xxoo
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_ooox
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_ooxo
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_oxoo
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end
end
