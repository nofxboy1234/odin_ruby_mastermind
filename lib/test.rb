class Test
  attr_accessor :number, :dylan

  def initialize(number)
    @number = number
  end
end

def update(test)
  test.number = 2
end

t = Test.new(3)
p t
update(t)
p t
p t.dylan
