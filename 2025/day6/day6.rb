input = File.read("#{__dir__}/day6.txt")

# line "123   328  51  64", width = [5, 3, 4, 1]
# => ["123", "328", " 51", "64"]
def process_line(line, widths)
  widths
    .reduce([[], 0]) { |(res, i), w| [ res << line[i..i+w-1].rstrip, i+w ] }
    .first
end

# Parse the input into a hash representing the problems.
# Example:
#   <<~EOT
#     123 328  51  64 
#      45 64  387  23 
#       6 98  215  314
#     *   +   *    +  
#   EOT
#   =>
#   {
#     "*" => [["123", " 45", "  6"], [" 51", "387", "215"]],
#     "+" => [["328", "64", "98"], ["64", "23", "314"]]
#   }
def parse_problems(input)
  widths = input.lines.last.scan(/\s+/).map { _1.size + 1 }
  input.lines
    .map { |line| process_line(line, widths) }
    .transpose
    .group_by(&:last)
    .transform_keys(&:strip)
    .transform_values { _1.map { |x| x[...-1] } }
end

def solve(problems)
  problems["*"].map { _1.map(&:to_i).reduce(:*) }.sum +
  problems["+"].map { _1.map(&:to_i).reduce(:+) }.sum
end

# Part 1

problems = parse_problems(input)
result = solve(problems)
puts "Adding together all problem answers results in #{result}"


# Part 2

# ["64", "23", "314"] => [4, 431, 623]
# ["123", " 45", "  6"] => [1, 24, 356]
def process_nums_in_col(nums)
  max_num_width = nums.max_by(&:size).size
  nums.map { _1.ljust(max_num_width, " ") }
    .map(&:chars)
    .transpose
    .map { _1.join.to_i }
end

corrected = problems.transform_values do |op_problems|
  op_problems.map { |nums| process_nums_in_col(nums) }
end
result = solve(corrected)
puts "After understanding cephalopod math, the total is #{result}"
