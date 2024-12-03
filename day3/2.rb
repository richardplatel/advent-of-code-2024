
input = ARGF.read
rexp = /(don\'t\(\))|(do\(\))|(mul\(\d\d?\d?,\d\d?\d?\))/
on = true
sum = 0
input.scan(rexp).flatten.compact.each do |i|
  case i
  when "do()" ; on = true
  when "don't()" ; on = false
  else ; sum += i.scan(/\d+/).map(&:to_i).inject(:*) if on
  end
end
puts ("Sum: #{sum}")
