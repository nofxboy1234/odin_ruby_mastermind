# frozen_string_literal: true

# The CodeMaker class is responsible for representing a CodeMaker and how
# they create and guess a mastercode
class CodeMaker
  attr_reader :maker, :board

  def initialize(maker)
    @maker = maker
    @board = maker.board
  end

  def code
    maker.make_mastercode
  end
end
