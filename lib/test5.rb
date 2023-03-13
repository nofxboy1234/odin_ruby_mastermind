def do_stuff(thing)
  p thing
  thing += 1
end

a = 0
a = do_stuff(a) until a == 10
