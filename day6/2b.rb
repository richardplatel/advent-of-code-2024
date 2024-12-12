require 'set'

$board = ARGF.each_line.map do |l|
  l.chomp.split("")
end

$max_row = nil
$max_col = nil
$obstacles = Set[]
$initial_guard_pos = nil
$moves = [
  [ 0, -1], # up
  [ 1,  0], # right
  [ 0,  1], # down
  [-1,  0], # left
]
$initial_guard_dir = 0    # Guard is "^" in sample and input so be lazy




def print_board(guard_pos, visited, extra_obstacle=nil)
  return
  sleep(0.01)
  puts "\e[H\e[2J"
  (0..$max_col).each do | c |
    (0..$max_row).each do | r |
      if $obstacles.include?([r, c])
        print("📦")
      elsif extra_obstacle && extra_obstacle == [r, c]
        print ("🛢️")
      elsif guard_pos == [r, c]
        print ("👮")
      elsif visited.include?([r,c])
        print ("👣")
      else
        print ("  ")
      end
    end
    puts("")
  end
end

def read_board
  $max_row = $board.first.length - 1
  $max_col = $board.length - 1
  $board.each_with_index do |l, c|
    l.each_with_index do |i, r|
      if i == "#"
        $obstacles << [r, c]
      elsif i == "^"
        $initial_guard_pos = [r, c]
      end
    end
  end
end


def walk_the_floor(extra_obstacle=nil)
  guard_pos = $initial_guard_pos
  guard_dir = $initial_guard_dir
  visited = Set[]
  path = Set[]

  while true
    print_board(guard_pos, visited, extra_obstacle)
    if path.include?([guard_pos, guard_dir])
      # loop
      return false
    end
    visited << guard_pos
    path << [guard_pos, guard_dir]
    next_pos = [guard_pos[0] + $moves[guard_dir][0], guard_pos[1] + $moves[guard_dir][1]]
    if $obstacles.include?(next_pos) || (extra_obstacle && extra_obstacle == next_pos)
      guard_dir = (guard_dir + 1) % 4
      next
    end
    if next_pos[0] < 0 || next_pos[0] > $max_row || next_pos[1] < 0 || next_pos[1] > $max_col
      break
    end
    guard_pos = next_pos
  end
  visited
end

read_board

default_walk = walk_the_floor
default_walk.delete($initial_guard_pos)

barrels = Set[]
default_walk.each do |o|
  if !walk_the_floor(o)
    barrels << o
  end
end


puts("Woo")
puts(barrels)
puts(barrels.length)
