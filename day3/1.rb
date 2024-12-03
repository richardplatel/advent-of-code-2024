

# state => { on_character => [function(c), next_state] }
$state_machine = {
  expecting_m:   {"m": [:reset, :expecting_u]},
  expecting_u:   {"u": [nil, :expecting_l]},
  expecting_l:   {"l": [nil, :expecting_lb]},
  expecting_lb:  {"(": [nil, :expecting_d11]},
  expecting_d11: {
    "0123456789": [:write_d1, :expecting_d12],
  },
  expecting_d12: {
    "0123456789": [:write_d1, :expecting_d13],
    ",": [nil, :expecting_d21]
  },
  expecting_d13: {
    "0123456789": [:write_d1, :expecting_comma],
    ",": [nil, :expecting_d21]
  },
  expecting_comma: {",": [nil, :expecting_d21]},

  expecting_d21: {
    "0123456789": [:write_d2, :expecting_d22],
  },
  expecting_d22: {
    "0123456789": [:write_d2, :expecting_d23],
    ")": [:do_mul, :expecting_m]
  },
  expecting_d23: {
    "0123456789": [:write_d2, :expecting_rb],
    ")": [:do_mul, :expecting_m]
  },
  expecting_rb: { ")": [:do_mul, :expecting_m]}
}

def reset(c)
  $memory[:d1] = 0
  $memory[:d2] = 0
end

def write_d1(c)
  $memory[:d1] = $memory[:d1] * 10 + c.to_i
end

def write_d2(c)
  $memory[:d2] = $memory[:d2] * 10 + c.to_i
end

def do_mul(c)
  $memory[:sum] = $memory[:sum] + ($memory[:d1] * $memory[:d2])
end

$memory = {
  current_state: :expecting_m,
  d1: 0,
  d2: 0,
  sum: 0,
}

def do_state_machine(c)
  state = $state_machine[$memory[:current_state]]
  state.each do |inp, action|
    if inp.to_s.include?(c)
      handler, next_state = action
      unless handler.nil?
        send(handler, c)
        puts("\n🧠 #{handler}(#{c})")
      end
      $memory[:current_state] = next_state
      return true
    end
  end
  $memory[:current_state] = :expecting_m
  return false
end

$tape = ""
def print_state(c)
  $tape += c
  $tape = $tape[-25..-1] || $tape

  sleep(0.05)
  puts "\e[H\e[2J"
  $state_machine.keys.each_with_index do |k, i|
    state_part = "#{$memory[:current_state] == k ? "🟢" : "🔴" } #{k.to_s}".ljust(20)
    memory_part = "#{$memory.keys[i]}: ".rjust(15) + "#{$memory.values[i]}"
    puts(" #{state_part} | #{memory_part}")
  end

  puts("\n")
  puts($tape + "👀")



end

input = ARGF.read.chomp

input.each_char do |c|
  print_state(c)
  do_state_machine(c)
end

puts("HALT")
puts("Sum:\n#{$memory[:sum]}")
