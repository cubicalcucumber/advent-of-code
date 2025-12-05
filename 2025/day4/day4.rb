floor = File.readlines("#{__dir__}/day4.txt").map { |line| line.strip.chars }

# Part 1

def print_floor(floor)
  positions(floor).each do |x, y|
    print floor[x][y]
    puts if y == floor[0].size - 1
  end
end

def accessible_roll?(floor, x, y)
  return unless floor[x][y] == "@"

  coords = [[x-1, y-1], [x,   y-1], [x+1, y-1],
            [x-1,   y],             [x+1,   y],
            [x-1, y+1], [x,   y+1], [x+1, y+1]]

  coords.reject { |c| c.include?(-1) }
        .map { |c| floor.dig(*c) }
        .count("@") < 4
end

def positions(floor) = floor.size.times.to_a.product(floor[0].size.times.to_a)

result = positions(floor)
  .map { |x, y| accessible_roll?(floor, x, y) }
  .count(true)
puts "#{result} rolls of paper can be accessed immediately."

# Part 2

def remove_rolls((floor, removes_prev), _)
  new_floor = floor.map(&:dup)
  removes = 0

  positions(floor).each do |x, y|
    if accessible_roll?(floor, x, y)
      new_floor[x][y] = "."
      removes += 1
    end
  end

  [new_floor, removes_prev + removes]
end

result_floor, removes = floor.reduce([floor, 0], &method(:remove_rolls))

puts "After removing all accessible #{removes} rolls of paper, the floor looks like this:"
print_floor(result_floor)
