class Clue
  attr_reader :value

  def initialize(value)
    @value = value || %w[_ _ _ _]
  end

  def only_o_and_x?
    value.include?('o') && value.include?('x') && value.none?('_')
  end

  def all_o?
    value.all?('o')
  end

  def at(index)
    value.at(index)
  end
end
