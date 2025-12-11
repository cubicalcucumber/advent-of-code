input = File.read("#{__dir__}/day7.txt")

splitters = input.lines.map do |line|
  line.chars.filter_map.with_index { |c, i| i if c == "^" }
end
tachyon_index = input.lines.first.index("S")

# Part 1

def count_splits(splitters, tachyon_index)
  split_count = 0
  tachyons_in_row = [tachyon_index]

  splitters.flat_map do |splitters_in_row|
    splitters_in_row.each do |s|
      next unless tachyons_in_row.include?(s)

      tachyons_in_row += [s-1, s + 1]
      tachyons_in_row.delete(s)
      split_count += 1
    end
  end

  split_count
end

splits = count_splits(splitters, tachyon_index)
puts "The beam will be split #{splits} times"

# Part 2

# Propagate a single tachyon beam downward through the manifest from a given
# position. There are two cases to consider:
#   - The beam encounters a splitter: return the two positions of the spawned
#     tachyon beams.
#   - The beam leaves the manifold: return an empty array.
def propagate(splitters, position)
  x, y = position
  splitters[y..].each_with_index do |sps, offset|
    return [[x-1, y+offset], [x+1, y+offset]] if sps.include?(x)
  end
  []
end

def count_timelines(splitters, pos)
  @memo ||= {}
  return @memo[pos] if @memo.has_key?(pos)

  positions = propagate(splitters, pos)
  result = positions.empty? ? 1 : positions.map { |xs| count_timelines(splitters, xs) }.sum

  @memo[pos] = result
end

result = count_timelines(splitters, [tachyon_index, 1])
puts "A single tachyon ends up in #{result} timelines"
