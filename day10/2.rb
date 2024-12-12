require 'set'

Node = Struct.new('Node', :height, :goes_tos, :nabes)

field = {}
ARGF.each_line.each_with_index do | line, row|
  line.chomp.each_char.each_with_index do | height, col|
    height = height.to_i
      field[[row, col]] = Node.new(
        height:,
        goes_tos: height == 9 ? [[row, col]] : [],
        nabes: [
          [row - 1 , col    ],
          [row + 1 , col    ],
          [row     , col - 1],
          [row     , col + 1],
        ],
      )
  end
end

# field.each do |coords, node|
#   puts("#{coords} - #{node}")
# end

(0..8).to_a.reverse.each do |current_height |
  puts ("doing #{current_height}")
  field.values.filter{ |node| node.height == current_height}.each do |node|
    node.nabes.map { |coords | field[coords] }.compact.filter { |nabe| nabe.height == current_height + 1 }.each do |nabe|
      node.goes_tos += nabe.goes_tos
    end
  end
end

sum = 0
field.filter { |coords, node| node.height == 0 }.each do |coords, node|
  puts("#{coords} - #{node}")
  sum += node.goes_tos.length
end

puts ("\nPaths: #{sum}")
