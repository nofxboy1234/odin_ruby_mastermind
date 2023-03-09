class Clue
  attr_reader :value

  def initialize(value)
    @value = value || %w[_ _ _ _]
  end

  def all_x?
    value.all?('x')
  end

  def all_o?
    value.all?('o')
  end

  def only_o_and_x?
    value.include?('o') && value.include?('x') && value.none?('_')
  end

  def only_u_and_x?
    value.include?('u') && value.include?('x') && value.none?('_')
  end

  def all_u?
    value.all?('_')
  end

  def at(index)
    value.at(index)
  end

  def format_clue(clue)
    clue.delete('_')
    clue.sort { |a, _b| a == 'x' ? -1 : 1 }
  end
end
