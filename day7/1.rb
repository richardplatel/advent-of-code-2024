
def possible(target, numbers)
  # puts ("possible: (#{target}, #{numbers.join(", ")})")
  if numbers.length == 1
    return target == numbers[0]
  end
  x = numbers.pop
  return (target >= x && possible(target - x, numbers.dup)) || (target % x == 0 && possible(target/x, numbers.dup) )
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
