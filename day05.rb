input = "3-5
10-14
16-20
12-18

1
5
8
11
17
32".lines.map(&:chomp)
input = File.readlines('data05.txt').map(&:chomp)

ranges = []

until input.first.empty?
  ranges << Range.new(*input.shift.split('-').map(&:to_i))
end

ids = []

until input.empty?
  ids << input.shift.to_i
end

puts ids.count { |id| ranges.any? { |r| r.include?(id) } }
