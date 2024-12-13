def solve(ax, ay, bx, by, tx, ty)
  solutions = []
  press_a = 0
  while(tx >= 0 && ty >=0)
    if(tx % bx== 0 && ty % by == 0 && (tx / bx) * by == ty)
      solutions << [press_a, tx/bx]
    end
    press_a += 1
    tx -= ax
    ty -= ay
  end
  solutions
end




sum = ARGF.each_line.map do |line|
  m = /X[+|=](\d+), Y[+|=](\d+)/.match(line)
  m[1..].map(&:to_i) if m
end.compact.each_slice(3).map do |game|
  solutions = solve(*(game.flatten)).sort
  costs = solutions.map { |s| s[0] * 3 + s[1]}
  puts ("game: #{game}, solutions: #{solutions} costs: #{costs}")
  costs.sort.first
end.compact.sum

puts ("Sum: #{sum}")
