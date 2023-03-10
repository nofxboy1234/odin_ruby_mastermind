# bad
# class A
# end

class A
  @@test = 10

  attr_reader :number

  def self.test
    # class_variable_get(:@@test)
    @@test
  end

  def initialize
    @number = 19
  end

  def test
    @@test * @@test
  end
end

# class A; end
# A.class_variable_set(:@@test, 10)

# p A.class_variable_get(:@@test)
p A.test
p A.new.test

# A.test('test', 20)
# p A.class_variable_get(:@@test)
# a = A.new
# p a.test
# p a.number
# p A.number
# p a.test2
