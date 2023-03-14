class Computer < Player
  def choose_mastercode
    # random_code.join
    '1234'
  end

  def guess_mastercode
    # Guess.new(board.guess_pegs.last).guess_pegs

    Guess.new(all_o).guess_pegs
  end

  def all_o
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  # should never happen
  def only_o_and_x_1oa
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_2oa
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_2ob
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_2oc
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_2od
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'x', 2)
    peg3 = GuessPeg.new('4', 'o', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_2oe
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'x', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_2of
    peg0 = GuessPeg.new('1', 'x', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_3oa
    peg0 = GuessPeg.new('1', 'o', 0)
    peg1 = GuessPeg.new('2', 'o', 1)
    peg2 = GuessPeg.new('3', 'o', 2)
    peg3 = GuessPeg.new('4', 'x', 3)
    [] << peg0 << peg1 << peg2 << peg3
  end

  def only_o_and_x_3ob
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
