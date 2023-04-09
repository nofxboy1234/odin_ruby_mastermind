# frozen_string_literal: true

# The NullCodeRow class is responsible for an uninitialized Code Row
class NullCodeRow
  attr_reader :pegs

  def valid?
    false
  end

  def to_s
    'null code row'
  end
end
