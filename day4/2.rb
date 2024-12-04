$input = ARGF.each_line.map { |l| l.chomp.split("")}

$rows = $input.length
$cols = $input.first.length

valid_crosses = [
  "MSAMS", "SMASM", "MMASS", "SSAMM"
]

sum = 0
(0...$rows-2).each do |r|
  (0...$cols-2).each do |c|
    # 0 . 1
    # . 2 .
    # 3 . 4
    cross = $input[r][c] + $input[r][c+2] + $input[r+1][c+1] + $input[r+2][c] + $input[r+2][c+2]
    sum += 1 if valid_crosses.include?(cross)
  end
end

puts ("Sum: #{sum}")
