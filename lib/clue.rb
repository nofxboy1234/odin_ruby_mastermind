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

  def all_underscore?
    value.all('_')
  end

  def all_nil?
    value.all(nil)
  end

  def at(index)
    value.at(index)
  end
end
