disk = []

id = 0
on = true

DFile = Data.define(:id, :length)
Free = Struct.new('File', :id, :length)

ARGF.read.chomp.each_char do |c|
  c = c.to_i
  if on
    disk << DFile.new(id, c)
    id += 1
    on = false
  else
    disk << Free.new(nil, c)
    on = true
  end
end

def expand_disk(disk, &block)
  disk.each do |b|
    b.length.times {yield b.id}
  end
end

def print_disk(disk)
  expand_disk(disk) do |c|
    print(c.nil? ? '.' : c)
  end
  puts ("")
end

def sum_disk(disk)
  idx = 0
  sum = 0
  expand_disk(disk) do |c|
    if c
      sum += c * idx
    end
    idx += 1
  end
  sum
end

file_id = disk.last.id
while (file_id >= 0)
  # print_disk(disk)
  file_index = disk.find_index {|b| b.id == file_id}
  file = disk[file_index]
  # puts ("moving #{file_id} at index #{file_index}")
  free_index = disk.find_index { |b| b.id.nil? && b.length >= file.length}
  if free_index && free_index < file_index
    fr = disk[free_index]
    # puts ("Looks like I can move #{file_index} to #{free_index}")
    disk[file_index - 1].length += file.length
    disk.delete_at(file_index)
    disk.insert(free_index, file)
    fr.length -= file.length
  end
  file_id -= 1
end
puts sum_disk(disk)

# get the index of file_id
# find the first free block of size at least that of file_id with idx less than that of file_id
# insert file before the free block
# remove file from previous location
# shorten free block by the length of file id
