input = File.read("#{__dir__}/day2.txt")

# Part 1

def parse_range(rng_str) = Range.new(*rng_str.split("-").map(&:to_i))
def digit_count(num) = Math.log10(num).floor + 1

def invalid1?(id)
  count = digit_count(id)
  # ex.: 123456
  # last chunk    pattern   id
  # 456        => 456456 == 123456?
  last_chunk = id % 10 ** (count / 2)
  last_chunk * 10 ** (count / 2) + last_chunk == id
end

result = input
  .split(",")
  .flat_map { |str| parse_range(str).to_a }
  .select { |id| invalid1?(id) }
  .sum

puts "All invalid IDs summed up: #{result}"


# Part 2

def invalid2?(id)
  # ex.: 123456
  # first chunk    pattern   id
  # 1           => 111111 == 123456?
  # 12          => 121212 == 123456?
  # 123         => 123123 == 123456?
  count = digit_count(id)
  (1..count / 2).any? do |chunk_size|
    first_chunk = id / 10 ** (count - chunk_size)

    pattern = 0
    0.step(count - 1, chunk_size) do |exp|
      pattern += first_chunk * 10 ** exp
    end

    pattern == id
  end
end

result = input
  .split(",")
  .flat_map { |str| parse_range(str).to_a }
  .select { |id| invalid2?(id) }
  .sum

puts "All invalid IDs summed up: #{result}"
