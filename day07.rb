require_relative 'helpers'

input = 
'.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............'.lines.map(&:chomp)
input = File.readlines('data07.txt').map(&:chomp)

start = [1, input[0].index('S')]

queue = [start]
splits = 0

while queue.any?
  i, j = queue.pop
  loop do
    break if j >= input[0].length
    break if i >= input.length
      
    case input[i][j]
    when '.'
      input[i][j] = '|'
    when '|'
      # already visited; do nothing
      break
    when '^'
      splits += 1
      queue << [i, j + 1]
      queue << [i, j - 1]
      break
    end

    i += 1
  end
end


puts input
puts splits