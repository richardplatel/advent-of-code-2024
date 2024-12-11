
def possible(target, numbers)
  # puts ("possible: (#{target}, #{numbers.join(", ")})")
  if numbers.length == 1
    return target == numbers[0]
  end
  x = numbers.pop

  # if target != x but ends with x, try un-concatenating x from target
  catable = false
  if (target != x)
    ts = target.to_s
    xs = x.to_s
    tcat = 0
    if ts.end_with?(xs)
      catable = true
      tcat = ts.chomp(xs).to_i
    end
  end

  return (catable && possible(tcat, numbers.dup)) || (target >= x && possible(target - x, numbers.dup)) || (target % x == 0 && possible(target/x, numbers.dup) )
end


sum = 0
ARGF.each_line do |l|
  l.chomp!
  target, rest = l.split(': ')
  numbers = rest.split(" ").map(&:to_i)
  target = target.to_i
  if possible(target, numbers)
    # puts ("Yes!")
    sum += target
  end
  # puts ("-----------")
end

puts ("Sum: #{sum}")
