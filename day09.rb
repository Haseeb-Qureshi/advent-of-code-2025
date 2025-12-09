require_relative 'helpers'

input = File.readlines('data09.txt').map(&:chomp)

coords = input.map { |s| s.split(',').map(&:to_i) }
puts coords.combination(2).map { |a, b| (a[0] - b[0]).abs.next * (a[1] - b[1]).abs.next }.max

# Part 2

# Transform all of these numbers into RELATIVE numbers across each axis? And then do a good old-fashioned BFS from inside and literally mark the numbers.
# Be as dumb as possible!

xs_map = {}
ys_map = {}

coords.map(&:first).sort.each_with_index { |el, i| xs_map[el] = i }
coords.map(&:last).sort.each_with_index { |el, i| ys_map[el] = i }

transformed_coords = coords.map { |(x, y)| [xs_map[x], ys_map[y]] }

grid = Array.new(xs_map.values.max.next) { Array.new(ys_map.values.max.next) { '.' } }
(transformed_coords + [transformed_coords.first]).each_cons(2) do |(x1, y1), (x2, y2)|
  if x1 == x2
    Range.new(*[y1, y2].sort).each { |y| grid[x1][y] = 'X' }
  else
    Range.new(*[x1, x2].sort).each { |x| grid[x][y1] = 'X' }
  end
end

def bfs!(orig_x, orig_y, grid)
  queue = [[orig_x, orig_y]]
  seen = Set.new
  until queue.empty?
    x, y = queue.shift
    next if seen.include?([x, y])
    next if grid[x][y] == 'X'
    grid[x][y] = 'X'
    
    DIFFS.each do |dx, dy|
      next unless (x + dx).between?(0, grid.length - 1)
      next unless (y + dy).between?(0, grid[0].length - 1)
      queue << [dx + x, dy + y]
    end
  end
end

def contains_all_Xs?(x1, y1, x2, y2, grid)
  Range.new(*[x1, x2].sort).all? do |x|
    Range.new(*[y1, y2].sort).all? do |y|
      grid[x][y] == 'X'
    end
  end
end

x, y = transformed_coords.first

bfs!(x - 1, y - 1, grid)

rects_with_areas = coords.combination(2).map { |a, b| [a, b, (a[0] - b[0]).abs.next * (a[1] - b[1]).abs.next] }.sort_by(&:last)
true_rect = rects_with_areas.reverse.find do |a, b, _|
  rx1, ry1 = a
  rx2, ry2 = b
  # Find the transformed rectangle and see if it fully contains Xs
  x1, y1 = xs_map[rx1], ys_map[ry1]
  x2, y2 = xs_map[rx2], ys_map[ry2]
  contains_all_Xs?(x1, y1, x2, y2, grid)
end

puts true_rect.last