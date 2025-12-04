input = File.readlines("#{__dir__}/day3.txt")

# Parts 1 and 2

def to_digits(num) = num.to_s.chars.map(&:to_i)
def to_num(digits) = digits.join.to_i

def propagate(window, num)
  candidates = [window] + window.combination(window.size - 1).map { |xs| xs << num }
  biggest_num = candidates.map(&method(:to_num)).max
  to_digits(biggest_num)
end

def joltage(bank, window_size:)
  ds = to_digits(bank)
  window = ds[0...window_size]
  to_num(ds[window_size..].reduce(window, &method(:propagate)))
end

result = input.map(&:to_i)
  .map { |bank| joltage(bank, window_size: 2) }
  .sum
puts "Total output joltage when turning on 2 batteries: #{result}"

result = input.map(&:to_i)
  .map { |bank| joltage(bank, window_size: 12) }
  .sum
puts "Total output joltage when turning on 12 batteries: #{result}"
