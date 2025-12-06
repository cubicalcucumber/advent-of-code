input = File.read("#{__dir__}/day3.txt")

# Part 1

result = input.scan(/mul\((\d+),(\d+)\)/)
  .map { _1.map(&:to_i) }
  .map { _1 * _2 }
  .sum

puts "All multiplications add up to #{result}"


# Part 2

regex = Regexp.union(
  /(do)\(\)/,
  /(don't)\(\)/,
  /mul\((\d+),(\d+)\)/)
parsed = input.scan(regex).map(&:compact)

result, _ = parsed.reduce([0, true]) do |(result, enabled), command|
  case command
  in ["do"]    then enabled = true
  in ["don't"] then enabled = false
  in [x, y]    then result += x.to_i * y.to_i if enabled
  end
  [result, enabled]
end

puts "All enabled multiplications add up to #{result}"
