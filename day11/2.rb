flat_field = ARGF.read.split(" ").map(&:to_i)

field = flat_field.tally



def blunk(n)
  ns = n.to_s
  if n == 0
    [1]
  elsif ns.length % 2 == 0
    right = ns.length / 2
    left = right - 1
    [ns[..left].to_i, ns[right..].to_i]
  else
    [n * 2024]
  end
end

75.times do |i|
  field_next = Hash.new(0)
  field.each do |stone, count|
    blunk(stone).each { | s | field_next[s] += count }
  end
  field = field_next
  # puts ("#{field}\n\n")
end

puts("Sum: #{field.values.sum}")
