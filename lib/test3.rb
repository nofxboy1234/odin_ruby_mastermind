class Entity
  @instances = 0

  class << self
    attr_accessor :instances  # provide class methods for reading/writing
  end

  def initialize
    self.class.instances += 1
    @number = self.class.instances
  end

  def who_am_i
    "I'm #{@number} of #{self.class.instances}"
  end

  def self.total
    @instances
  end

  def hello
    @number
  end
end

entities = Array.new(9) { Entity.new }

p entities[6].who_am_i  # => "I'm 7 of 9"
p Entity.instances      # => 9
p Entity.total          # => 9
# p entities[6].hello
