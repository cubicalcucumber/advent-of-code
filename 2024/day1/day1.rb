input = File.read("#{__dir__}/day1.txt")

# Part 1

result = input.scan(/(\d+)\s+(\d+)/)
  .transpose
  .map(&:sort)
  .transpose
  .map { |x, y| (x.to_i - y.to_i).abs }
  .sum
puts "The total distance between the lists is #{result}"

# Part 2

left, right = input.scan(/(\d+)\s+(\d+)/)
  .transpose
  .map { _1.map(&:to_i) }

occurrences = right.tally
score = left.sum { |l| l * occurrences.fetch(l, 0) }
puts "The similarity score is #{score}"
