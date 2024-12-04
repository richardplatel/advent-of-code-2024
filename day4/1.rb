$input = ARGF.each_line.map { |l| l.chomp.split("")}
$rows = $input.length
$cols = $input.first.length

# co-ordinates on the left and bottom sides of the array
def edges
  (0...$rows).map{ |r| [r, 0] } +
    (1...$cols).map{ |c| [$rows - 1, c]}
end

# list of co-ordinates of the diagonal going up and left starting from 'start'
def diag(start)
  result = [start]
  while true
    return result if result.last[0] == 0 || result.last[1] == $cols - 1
    result << [result.last[0] - 1, result.last[1] + 1]
  end
end

# list of all the up-left diagonals co-ordinates starting from each edge
def diagonals
  edges.map{ |e| diag(e)}
end

# diagonals in input array become rows
def rot45(ary)
  diagonals.map do |l|
    l.map {|c| ary[c[0]][c[1]]}.join("")
  end
end

hors = $input.map{ |l| l.join("") }
vert = $input.transpose.map{ |l| l.join("") }
dia1 = rot45($input)
dia2 = rot45($input.transpose.map(&:reverse)) # rotate input 90 degrees

def count_xmases(ary)
  ary.map { |l| l.scan(/XMAS/).count + l.scan(/SAMX/).count}.sum
end



result = [hors, vert, dia1, dia2].map{ |a| count_xmases(a)}.sum
puts ("Sum: #{result}")
