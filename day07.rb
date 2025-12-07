input = File.readlines('data07.txt').map(&:chomp).map(&:chars)

start = [1, input[0].index('S')]
queue = [start]
splits = 0

until queue.empty?
  i, j = queue.shift

  loop do
    break if j >= input[0].length
    break if i >= input.length
      
    case input[i][j]
    when '.'
      input[i][j] = '|'
    when '^'
      splits += 1
      queue << [i, j + 1]
      queue << [i, j - 1]
      break
    else # is a |, do nothing
      break
    end

    i += 1
  end
end

puts splits

# Part 2
# Go through line by line left-to-right
# Replace all of the |'s with their total input streams

input[0][input[0].index('S')] = 1 # set the first 1

input.each_with_index do |line, i|
  next if i == 0
  line.each_with_index do |c, j|
    above = input[i - 1][j]

    case c
    when '|'
      input[i][j] = above if above.is_a?(Integer)
    when '^'
      next unless above.is_a?(Integer)

      [j - 1, j + 1].each do |j2|
        if input[i][j2] == '|'
          input[i][j2] = above
        else # it's a number already
          input[i][j2] += above
        end
      end
    when Integer
      input[i][j] += above if above.is_a?(Integer)
    when '.'
      # do nothing
    else 
      raise 'wtf'
    end
  end
end

puts input.last.select { |el| el.is_a?(Integer) }.sum