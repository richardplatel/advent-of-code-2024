require 'set'

$board = ARGF.each_line.map do |l|
  l.chomp.split("")
end

$max_row = nil
$max_col = nil
$prime_route = nil
$visited = []
$initial_obstacles = nil
$obstacles = Set[]
$initial_guard_pos = nil
$guard_pos = nil
$possible_obstacles = Set[]
$moves = [
  [ 0, -1], # up
  [ 1,  0], # right
  [ 0,  1], # down
  [-1,  0], # left
]
$guard_dir = 0    # Guard is "^" in sample and input so be lazy




def print_board
  (0..$max_col).each do | c |
    (0..$max_row).each do | r |
      if $obstacles.include?([r, c])
        print("📦")
      elsif $guard_pos == [r, c]
        print ("👮")
      elsif $visited.include?([r,c])
        print ("👣")
      elsif $possible_obstacles.include?([r,c])
        print ("🛢️")
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
        $guard_pos = [r, c]
      end
    end
  end
  $initial_guard_pos = $guard_pos
  $initial_obstacles = $obstacles
end

read_board
print_board

while true
  #puts "\e[H\e[2J"
  #print_board
  $visited << $guard_pos
  next_pos = [$guard_pos[0] + $moves[$guard_dir][0], $guard_pos[1] + $moves[$guard_dir][1]]
  if $obstacles.include?(next_pos)
    $guard_dir = ($guard_dir + 1) % 4
    next
  end
  if next_pos[0] < 0 || next_pos[0] > $max_row || next_pos[1] < 0 || next_pos[1] > $max_col
    break
  end
  $guard_pos = next_pos
  #sleep(0.1)
end

$prime_route = $visited
$prime_route.shift

$possible_obstacles = Set[]
$prime_route.each do |p|
  $obstacles = $initial_obstacles.dup
  # puts($obstacles)
  $obstacles << p
  $visited = Set[]
  $guard_pos = $initial_guard_pos
  $guard_dir = 0

  while true
    #puts "\e[H\e[2J"
    #print_board
    if $visited.include?([$guard_pos, $guard_dir])
      $possible_obstacles << $guard_pos
      break
    end
    $visited << [$guard_pos, $guard_dir]
    next_pos = [$guard_pos[0] + $moves[$guard_dir][0], $guard_pos[1] + $moves[$guard_dir][1]]
    if $obstacles.include?(next_pos)
      $guard_dir = ($guard_dir + 1) % 4
      next
    end
    if next_pos[0] < 0 || next_pos[0] > $max_row || next_pos[1] < 0 || next_pos[1] > $max_col
      break
    end
    $guard_pos = next_pos
    #sleep(0.0001)
  end
  #sleep (0.1)
end



puts ("Woo")
puts ($possible_obstacles.length)
puts ($possible_obstacles)
print_board
