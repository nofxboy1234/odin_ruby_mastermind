# frozen_string_literal: true

require_relative 'colorable_string'

# The MainMenu class is responsible for displaying menus in the game
class MainMenu
  using ColorableString

  attr_reader :choice, :min_choice, :max_choice

  def initialize(min_choice, max_choice)
    initialize_choice
    @min_choice = min_choice
    @max_choice = max_choice

    # main_loop
  end

  def initialize_choice
    @choice = RangeNumber.new('0', min_choice, max_choice)
  end

  def main_loop
    initialize_choice

    until valid_choice?
      show
      choose
    end
  end

  private

  def rules
    turns = '12 turns'.fg_color(:cyan)
    number = '4 digit number'.fg_color(:cyan)
    duplicates = 'duplicates'.fg_color(:cyan)
    range = '1-6'.fg_color(:cyan)
    clue_row = 'clue row'.fg_color(:cyan)
    exact = 'exact'.fg_color(:cyan)
    partial = 'partial'.fg_color(:cyan)
    empty = 'empty'.fg_color(:cyan)
    number_and_position = 'number and position'.fg_color(:cyan)
    another_position = 'another position'.fg_color(:cyan)
    no_more_occurrences = 'no more occurrences'.fg_color(:cyan)
    previous_guesses = 'previous guesses'.fg_color(:cyan)
    bottom_of_the_list = 'bottom of the list'.fg_color(:cyan)
    code_breaker = 'CodeBreaker'.fg_color(:cyan)
    code_maker = 'CodeMaker'.fg_color(:cyan)

    unique_letter = 'unique letter A-D'.fg_color(:cyan)
    partial_clue = 'partial clue'.fg_color(:cyan)
    empty_clue = 'empty clue'.fg_color(:cyan)
    new_numbers = 'new numbers'.fg_color(:cyan)
    star = '*'.fg_color(:cyan)

    "You have a maximum of #{turns} to decipher the Mastercode.\n" \
      "The Mastercode is a #{number} that can contain #{duplicates}.\n" \
      "Each digit in the number can be #{range} inclusive.\n" \
      "\n" \
      "You can choose to be the #{code_maker} or the #{code_breaker}.\n" \
      "\n" \
      "After each turn, the #{code_breaker} will get given a #{clue_row}.\n" \
      "\n" \
      "Each 'peg' in your guess will be given one of the following clues:\n" \
      "\n" \
      "x: An #{exact} match - the #{number_and_position} of the peg matches a peg in the Mastercode.\n" \
      "o: A #{partial} match - the number matches a peg in the Mastercode, but the peg is in #{another_position}.\n" \
      "_: An #{empty} match - there are #{no_more_occurrences} of this number in the Mastercode.\n" \
      "\n" \
      "All #{previous_guesses} and clue rows will be shown for each turn,\n" \
      "with the last guess and clue at the #{bottom_of_the_list}.\n" \
      "\n" \
      "This version of Mastermind shows clues with each peg in the same position\n" \
      "as each of your guess pegs, as well as showing 'empty matches'\n" \
      "to make it a bit easier to make your next guess.\n" \
      "\n" \
      "When playing as the #{code_maker}, you will get to see how the computer makes its guesses:\n" \
      "Each peg will be assigned a #{unique_letter}, to visualize the decision making.\n" \
      "The computer will first move any #{partial_clue} pegs around.\n" \
      "It will then assign #{new_numbers} to any #{empty_clue} pegs.\n" \
      "Any #{empty_clue} pegs with #{new_numbers} assigned will get a #{star} to the right of its letter.\n" \
      "\n"
  end

  def show
    puts "Welcome to Mastermind!\n".fg_color(:cyan)
    puts rules
    puts "Please choose an option by entering '1', '2', or '3':".fg_color(:green)
    puts '1. Play as the CodeBreaker'.fg_color(:orange)
    puts '2. Play as the CodeMaker'.fg_color(:yellow)
    puts '3. Quit'.fg_color(:pink)
  end

  def choose
    @choice = RangeNumber.new(gets.chomp.strip.downcase, min_choice, max_choice)
    show_invalid_message unless valid_choice?
  end

  def show_invalid_message
    puts "\nThe menu choice you entered was invalid. Please try again.\n".fg_color(:pink)
  end

  def valid_choice?
    choice.valid?
  end
end
