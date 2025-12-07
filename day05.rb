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

# Part 2

# Compact the ranges to make them contiguous

sorted_ranges = ranges.sort_by(&:begin)
combined_ranges = [sorted_ranges.shift]

sorted_ranges.each do |r2|
  r1 = combined_ranges.last

  if r2.begin > r1.end
    combined_ranges << r2
  else r1.begin == r2.begin
    combined_ranges[-1] = Range.new(r1.begin, [r1.end, r2.end].max)
  end
end

puts combined_ranges.sum(&:size)