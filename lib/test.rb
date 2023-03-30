# frozen_string_literal: true

s = 'abc'
# t = 'abc'
t = s
p s.object_id
p t.object_id

s.capitalize!
p s


def hello1
  p 'hello1'
end

def hello2(test)
  p 'hello2'
end

def hello3?
  p 'hello3?'
end

def hello4?(test)
  p 'hello4?'
end

hello1
hello1
hello2('test')
hello2('test')
hello3?
hello3?
hello4?('test')
hello4?('test')

