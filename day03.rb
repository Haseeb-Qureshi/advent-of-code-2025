input = File.readlines('data03.txt').map(&:chomp)

def largest_joltage(line)
  # find the highest digit from the left
  max, max_index = line.chars[0..-2].each_with_index.max_by(&:first).map(&:to_i) 
  
  # find highest_digit from the right of that
  second_digit = line[max_index + 1..-1].chars.max_by(&:to_i).to_i

  10 * max + second_digit
end

puts input.sum { |line| largest_joltage(line) }

# Part 2

def rest_of_joltage(line, more: 12)
  return '' if more == 0
  max, max_index = line.chars[0..-more].each_with_index.max_by(&:first)
  max + rest_of_joltage(line[max_index + 1..-1], more: more - 1)
end

puts input.sum { |line| rest_of_joltage(line).to_i }