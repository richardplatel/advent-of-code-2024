disk = []

id = 0
on = true

ARGF.each_char do |c|
  c = c.to_i
  if on
    disk += (0...c).map {id}
    id += 1
    on = false
  else
    disk += (0...c).map{nil}
    on = true
  end
end

def print_disk(d, i, g)
  d.each { |id| print(id ? id : '.' )}
  puts("")
  d.each_with_index do |d, x|
    if x == i
      print "i"
    elsif x == g
      print "g"
    else
      print "-"
    end
  end
  puts("\n\n")

end

insert = 0
grab = disk.length - 1
while (insert < grab)
  # print_disk(disk, insert, grab)
  if disk[insert] != nil
    insert += 1
  elsif disk[grab] == nil
    grab -= 1
  else
    disk[insert] = disk[grab]
    disk[grab] = nil
    insert += 1
    grab -= 1
  end
end
print_disk(disk, insert, grab)

sum = disk.compact.each_with_index.map { |block_id, idx| block_id * idx }.sum
puts ("sum: #{sum}")
