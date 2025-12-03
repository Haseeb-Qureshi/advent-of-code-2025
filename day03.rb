input = File.readlines('data03.txt').map(&:chomp)
# input = '987654321111111
# 811111111111119
# 234234234234278
# 818181911112111'.lines.map(&:chomp)

def largest_joltage(line)
  # find the highest digit from the left
  max = 0
  max_index = 0
  
  line.chars[0..-2].each_with_index do |battery, i|
    next unless battery.to_i > max
    max, max_index = battery.to_i, i
  end
  
  # find highest_digit from the right of that
  second_digit = line[max_index + 1..-1].chars.max_by(&:to_i).to_i

  10 * max + second_digit
end

puts input.sum { |line| largest_joltage(line) }