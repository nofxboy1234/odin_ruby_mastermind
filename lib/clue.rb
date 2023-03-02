class Clue
  attr_reader :value

  def initialize(value = [])
    @value = value
  end

  def at(index)
    value[index]
  end
end
