input = File.readlines("#{__dir__}/day2.txt")
reports = input.map { _1.strip.split(" ").map(&:to_i) }

# Part 1

def safe?(report)
  delta = report.each_cons(2).map { |x, y| y - x }

  in_range = delta.map(&:abs).all? { |d| d >= 1 && d <= 3 }
  (delta.all?(&:negative?) || delta.all?(&:positive?)) && in_range
end

safe_count = reports.count { |r| safe?(r) }
puts "#{safe_count} reports are safe"

# Part 2

def with_level_removed(report, i) = report.dup.tap { |r| r.delete_at(i) }

def actually_safe?(report)
  report.size.times
    .map { |i| with_level_removed(report, i) }
    .any? { |r| safe?(r) }
end

actually_safe_count = reports.count { |r| actually_safe?(r) }
puts "#{actually_safe_count} reports are actually safe"
