# frozen_string_literal: true

# The Computer class is responsible for representing a Computer and how
# they create and guess a mastercode
class Computer
  def make_mastercode
    random_code.join
    '4341'
  end

  def break_mastercode
    random_code.join
  end

  private

  def random_code
    (1..4).inject([]) { |random_numbers, _n| random_numbers << rand(1..6) }
  end
end
