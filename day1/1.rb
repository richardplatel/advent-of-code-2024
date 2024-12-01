
# (a1 - b1) + (a2 - b2) + (a3 - b3) ...
#  = a1 + a2 + a3... - b1 - b2 - b3 ...
#  = a1 + a2 + a3... - (b1 + b2 + b3...)

list1 = []
list2 = []

ARGF.each_line.map do |line|
  (a, b) = line.chomp.split(/\s+/)
  list1 << a.to_i
  list2 << b.to_i
end


# puts("list1: #{list1}")
# puts("list2: #{list2}")

list1 = list1.sort
list2 = list2.sort

result = list1.zip(list2).map do | x |
  (x[0] - x[1]).abs
end.sum

puts ("result:\n#{result}")
