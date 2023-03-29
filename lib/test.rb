# frozen_string_literal: true

s = 'abc'
# t = 'abc'
t = s
p s.object_id
p t.object_id

s.capitalize!
p s