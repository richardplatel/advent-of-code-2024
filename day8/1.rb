
require 'set'
antennea = Hash.new([])
$max = 0

ARGF.each_line.each_with_index do |l, row|
  l.chomp.split("").each_with_index do |a, col|
    if a != '.'
      antennea[a] += [[row, col]]
    end
  end
  $max = row # assume square map
end


def antinodes(a, b)
  distance = [a[0] - b[0], a[1] - b[1]]
  return [a[0] + distance[0], a[1] + distance[1]], [b[0] - distance[0], b[1] - distance[1]]
end

def in_bounds(a)
  a.all? { |c| c >= 0 && c <= $max}
end

result = Set.new([])
antennea.map do |a, nodes|
  nodes.combination(2).map do |pair|
    # puts ("#{a} pair: #{pair}")
    result += antinodes(*pair)
  end
end

result.filter! { |n| in_bounds(n)}

puts ("antinodes: #{result.length}")
puts result.to_s
