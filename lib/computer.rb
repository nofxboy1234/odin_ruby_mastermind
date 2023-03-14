class Computer < Player
  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    # Guess.new(board.guess_pegs.last).guess_pegs

    Guess.new(all_o).guess_pegs
  end

  def total_different_patterns_in_mastermind
    (1..6).to_a.repeated_permutation(4).to_a.size # 1296
  end

  def temp
    a = %w[o o x x]
    a.permutation(4).to_a.uniq
    a.repeated_permutation(4).to_a.uniq # reject illegal clues e.g. oxxx
  end

  def all_o
    # [1, 2, 3, 4].permutation(4).to_a.size == 24
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_oxxo
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
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

  def only_o_and_x_ooxx
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
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

  def only_o_and_x_oxox
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_xoox
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_ooox
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_xooo
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_3oc
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_3od
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def all_u_a
    peg0 = GuessPeg.new('1', '_', 0)
    peg1 = GuessPeg.new('2', '_', 1)
    peg2 = GuessPeg.new('3', '_', 2)
    peg3 = GuessPeg.new('4', '_', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def all_u_b
    peg0 = GuessPeg.new('1', '_', 0)
    peg1 = GuessPeg.new('2', '_', 1)
    peg2 = GuessPeg.new('2', '_', 2)
    peg3 = GuessPeg.new('6', '_', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_u_and_x_2ua
    peg0 = GuessPeg.new('1', '_', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', '_', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_xoux
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', '_', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_ouxx
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', '_', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_uoxx
    peg0 = GuessPeg.new('1', '_', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_xxuo
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', '_', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_xxou
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', '_', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_oxxu
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', '_', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_uxxo
    peg0 = GuessPeg.new('1', '_', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_ouux
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', '_', 1)
    peg2 = GuessPeg.new('3', '_', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_uoux
    peg0 = GuessPeg.new('1', '_', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', '_', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_uuox
    peg0 = GuessPeg.new('1', '_', 0)
    peg1 = GuessPeg.new('2', '_', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_ooux
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', '_', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_ouox
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', '_', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_uoox
    peg0 = GuessPeg.new('1', '_', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def o_u_and_x_xoou
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', '_', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end
end
