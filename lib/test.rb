# frozen_string_literal: true

# class TrueClass
#   def if_true
#     yield
#     self
#   end

#   def if_false
#     self
#   end
# end

# class FalseClass
#   def if_true
#     self
#   end

#   def if_false
#     yield
#     self
#   end
# end

# # (1 == 1).if_true { puts "evaluated block" }
# (true).if_true { puts "evaluated block" }
# (true).if_false { puts "evaluated block" }

# class Cat

# end

# c = Cat.new
# c.dylan = 'dylan'

green_rgb = "0;128;0"
str = 'hello'

puts "\e[38;2;#{green_rgb}m#{str}\e[0m world"
