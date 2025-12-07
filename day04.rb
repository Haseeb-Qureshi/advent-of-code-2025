require_relative 'helpers'

ROLL = '@'

input = File.readlines('data04.txt').map(&:chomp).map(&:chars)
input = "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.".lines.map(&:chars)

# if 3 or fewer in the 8 neighbor spots, then it's accessible by forklift

new_grid = Array.new(input.length) { Array.new(input[0].length) }

forklift_accessible = 0
input.each_index do |i|
  input[0].each_index do |j|
    if input[i][j] == ROLL && neighbors(input, i, j).count(ROLL) <= 3
      p [i, j, neighbors(input, i, j)]
      forklift_accessible += 1 
    end
  end
end

p neighbors(input, 0, 0)

puts forklift_accessible