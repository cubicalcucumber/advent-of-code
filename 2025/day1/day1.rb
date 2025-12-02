input = File.readlines("#{__dir__}/day1.txt")

# Part 1

def interpret(command)
  command.gsub(/[LR]/, "L" => "-", "R" => "").to_i
end

def count_zeros((dial_prev, zeros_prev), inc)
  dial = (dial_prev + inc) % 100
  [dial, zeros_prev + (dial == 0 ? 1 : 0)]
end

dial, zeros = input
  .map { interpret(_1) }
  .reduce([50, 0]) { count_zeros(_1, _2) }

puts "Dial is pointing at #{dial}, counted #{zeros} zeros."

# Part 2

def inv(x) = (100 - x) % 100

def count_clicks((dial_prev, clicks_prev), inc)
  if inc < 0
    clicks, dial = (inv(dial_prev) - inc).divmod(100)
    [inv(dial), clicks_prev + clicks]
  else
    clicks, dial = (dial_prev + inc).divmod(100)
    [dial, clicks_prev + clicks]
  end
end

dial, clicks = input
  .map { interpret(_1) }
  .reduce([50, 0]) { count_clicks(_1, _2) }

puts "Dial is pointing at #{dial}, it clicked #{clicks} times."
