require 'bigdecimal/util'


def solve(ax, ay, bx, by, tx, ty)
  tx += 10000000000000
  ty += 10000000000000

  # from target to x axis
  ax_intercept = ty - (ay * tx) / ax  # (Ab)
  bx_intercept = ty - (by * tx) / bx  # (Bb)

  ab = ax_intercept
  bb = 0

  am = ay / ax
  bm = by / bx

  # if ax_intercept < 0 && bx_intercept < 0 ....
  #if ax_intercept == 0 or bx_intercept == 0...

  # if am == bm ...

  # intersection of B from (0,0) and A from T
  ab_x = (ab - bb ) / (bm - am)
  ab_y = bm * ab_x + bb

  ab_x = ab_x.round
  ab_y = ab_y.round
  puts("(#{ab_x}, #{ab_y})")

  puts ("ab_x % bx #{ab_x % bx}")
  puts ("ab_y % by #{ab_y % by}")


  if ab_x % bx == 0 && ab_y % by == 0 && (tx - ab_x) % ax == 0 && (ty - ab_y) % ay == 0
    return [[((tx - ab_x) / ax).round, (ab_x / bx).round]]
  end


  []


end


sum = ARGF.each_line.map do |line|
  m = /X[+|=](\d+), Y[+|=](\d+)/.match(line)
  m[1..].map(&:to_d) if m
end.compact.each_slice(3).map do |game|
  solutions = solve(*(game.flatten)).sort
  costs = solutions.map { |s| s[0] * 3 + s[1]}
  puts ("game: #{game}, solutions: #{solutions} costs: #{costs}")
  costs.sort.first
end.compact.sum

puts ("Sum: #{sum}")
