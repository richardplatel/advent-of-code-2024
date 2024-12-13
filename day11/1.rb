field = ARGF.read.split(" ").map(&:to_i)

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

puts field.to_s

25.times do
  field = field.map{|stone| blunk(stone)}.flatten
end

puts ("Stones: #{field.length}")
