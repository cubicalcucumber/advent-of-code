input = File.read("#{__dir__}/day8.txt")
positions = input.lines.map { |line| line.split(",").map(&:to_i) }

class DisjointSets
  def initialize(things)
    @parents = things.size.times.to_a
    @mapping = things.zip(0..).to_h
  end

  def set_count = @parents.uniq.size

  def find(i) = @parents[@mapping[i]]

  def union(p, q)
    parent_of_q = find(q)
    parent_of_p = find(p)
    @parents.map! { |p| p == parent_of_q ? parent_of_p : p }
  end

  def to_sets
    sets = []
    @parents.each_with_index do |p, i|
      sets[p] ||= Set[]
      sets[p] << i
    end
    sets.compact
  end
end

def distance(p, q)
  Math.sqrt((p[0] - q[0])**2 + (p[1] - q[1])**2 + (p[2] - q[2])**2)
end

# Part 1

distances = positions.product(positions)
  .uniq { |p, q| [p, q].sort }
  .reject { |p, q| p == q }
  .map { |p, q, d| [p, q, distance(p, q)] }
  .sort_by { |p, q, d| d }

circuits = DisjointSets.new(positions)

1000.times do
  p, q = distances.shift
  circuits.union(p, q)
end

result = circuits.to_sets
  .sort_by(&:size)
  .reverse[0..2]
  .map(&:size)
  .reduce(:*)

puts "The sizes of the three largest circuits multiplied: #{result}"

# Part 2

# We continue merging within the same partition...
result = loop do
  p, q = distances.shift
  circuits.union(p, q)
  break p[0] * q[0] if circuits.set_count == 1
end

puts "The X coordinates of the last two junction boxes multiplied: #{result}"
