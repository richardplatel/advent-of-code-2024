
def is_safe(l)
increasing = nil
  l.each_cons(2) do | a, b|
    a = a.to_i
    b = b.to_i
    distance = a - b
    return false if a == b
    return false if distance.abs > 3
    if increasing.nil?
      increasing = a < b
    elsif a < b != increasing
      return false
    end
  end
  return true
end

safe = 0

ARGF.each_line.map do |line|
  level = line.chomp.split(/\s+/)
  safe += 1 if is_safe(level)
end

puts "safe count: \n#{safe}"
