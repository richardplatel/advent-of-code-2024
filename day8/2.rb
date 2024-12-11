
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
  g = distance[0].gcd(distance[1])
  slope = distance.map{|c| c / g }
  result = [a]
  n = [a[0] + slope[0], a[1] + slope[1]]
  while in_bounds(n)
    result += [n]
    n = [n[0] + slope[0], n[1] + slope[1]]
  end
  n = [a[0] - slope[0], a[1] - slope[1]]
  while in_bounds(n)
    result += [n]
    n = [n[0] - slope[0], n[1] - slope[1]]
  end
  return result
end

def in_bounds(a)
  a.all? { |c| c >= 0 && c <= $max}
end

result = Set.new([])
antennea.each do |a, nodes|
  nodes.combination(2).map do |pair|
    result += antinodes(*pair)
  end
end


puts ("antinodes: #{result.length}")
puts result.to_s
