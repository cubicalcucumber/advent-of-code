input = File.readlines("#{__dir__}/day3.txt")

# Parts 1 and 2

def to_digits(num) = num.to_s.chars.map(&:to_i)
def to_num(digits) = digits.join.to_i

# Update the current best selection given a new input `num` by checking all
# possible ways to apply `num` to the current window and choose the best one.
# Example:
#   window = [6,3,4], num = 5
#   Candidates are the old window [6,3,4] as well as [6,3,5], [6,4,5] and [3,4,5].
def update(window, num)
  candidates = [window] + window.combination(window.size - 1).map { |xs| xs << num }
  candidates.max_by { to_num(_1) }
end

# Find the maximum joltage a battery bank can produce.
def joltage(bank, window_size:)
  ds = to_digits(bank)
  # Start with the first `window_size` many digits as the initial best
  # selection of batteries and update the window given each joltage number
  # from the rest of the bank.
  window, rest = ds[0...window_size], ds[window_size..]
  to_num(rest.reduce(window, &method(:update)))
end

result = input.map(&:to_i)
  .map { |bank| joltage(bank, window_size: 2) }
  .sum
puts "Total output joltage when turning on 2 batteries: #{result}"

result = input.map(&:to_i)
  .map { |bank| joltage(bank, window_size: 12) }
  .sum
puts "Total output joltage when turning on 12 batteries: #{result}"
