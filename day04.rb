require_relative 'helpers'

ROLL = '@'

input = File.readlines('data04.txt').map(&:chomp).map(&:chars)

# if 3 or fewer in the 8 neighbor spots, then it's accessible by forklift

forklift_accessible = 0
input.each_index do |i|
  input[0].each_index do |j|
    next unless input[i][j] == ROLL
    forklift_accessible += 1 if neighbors(input, i, j).count(ROLL) <= 3
  end
end

puts forklift_accessible

# Part 2

rolls_to_remove = []
total_rolls_removed = 0

loop do
  input.each_index do |i|
    input[0].each_index do |j|
      next unless input[i][j] == ROLL
      rolls_to_remove << [i, j] if neighbors(input, i, j).count(ROLL) <= 3
    end
  end

  break if rolls_to_remove.empty?

  rolls_to_remove.each { |i, j| input[i][j] = '.' }
  total_rolls_removed += rolls_to_remove.count
  rolls_to_remove = []
end

puts total_rolls_removed