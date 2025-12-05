input = File.readlines("#{__dir__}/day5.txt").map(&:strip)

# Parts 1 and 2

def parse_range(str) = Range.new(*str.split("-").map(&:to_i))

def fresh?(ranges, id) = ranges.find { |r| r.cover?(id) }

def merge(ranges)
  ranges.sort_by(&:begin)
    .reduce([]) do |merged, range|
      current = merged.last
      if merged.empty? || current.end < range.begin
        merged << range
      else
        merged[-1] = Range.new(current.begin, [current.end, range.end].max)
      end

      merged
    end
end

idx = input.find_index { |line| line.empty? }
range_lines, id_lines = input[0...idx], input[idx + 1..]
ranges = merge(range_lines.map { |str| parse_range(str) })
ids = id_lines.map(&:to_i)

fresh_count = ids.count { |id| fresh?(ranges, id) }
puts "#{fresh_count} of the ingredient IDs are fresh"
puts "In total #{ranges.sum(&:size)} of the ingredient IDs are considered fresh"
