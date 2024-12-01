

list1 = []
list2 = []

ARGF.each_line.map do |line|
  (a, b) = line.chomp.split(/\s+/)
  list1 << a.to_i
  list2 << b.to_i
end

l1_counts = list1.tally
l2_counts = list2.tally
# puts ("l1_counts: #{l1_counts}")
# puts ("l2_counts: #{l2_counts}")
score = 0

l1_counts.each do |v, c|
  score += v * c * l2_counts.fetch(v, 0)
end

puts ("score: \n#{score}")
