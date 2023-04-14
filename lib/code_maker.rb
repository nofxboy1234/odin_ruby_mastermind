# frozen_string_literal: true

# The CodeMaker class is responsible for representing a CodeMaker and how
# they create and guess a mastercode
class CodeMaker
  attr_reader :maker

  def initialize(maker)
    @maker = maker
  end

  def code
    maker.make_mastercode
  end
end
