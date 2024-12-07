
$befores = Hash.new([])
$afters = Hash.new([])
def add_order(a,b)
  puts ("Adding (#{a}, #{b})")
  $befores[b] += [a]
  $afters[a] += [b]
end

def check_update(update)
  puts ("Doing Pages: #{update.join(" - ")}")
  update.each_with_index do |page, i|
    after = $afters.fetch(page, [])
    puts ("Page #{page} at index :#{i} must be before [#{after.join(", ")}]")
    after.each do |a|
      ai = update.index(a)
      if ai && ai < i
        puts ("Bad update, #{a} is before #{page} and must be after")
        return 0
      end
    end
  end
  puts ("Good update")
  return update[update.length / 2].to_i
end

$in_orders = true
$sum = 0
ARGF.each_line do |l|
  l.chomp!
  if l == ''
    $in_orders = false
    $befores.each do |k, v|
      puts("#{k} -> [#{v.join(", ")}]")
    end
    # $afters.each do |k, v|
    #   puts("#{k} <- [#{v.join(", ")}]")
    # end
    next
  end
  if $in_orders
    add_order(*l.split("|"))
  else
    $sum += check_update(l.split(","))
  end
end

puts ("Sum: #{$sum}")
