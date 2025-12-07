raw_input = File.readlines('data06.txt')

input = raw_input.map(&:split)
sum = input.transpose.sum do |line|
  line[0..-2].map(&:to_i).reduce(line.last)
end

puts sum

# Part 2

nums = raw_input[0..-2]
operators = raw_input[-1]

verticals = nums.map(&:chomp).map(&:chars).transpose.map(&:join)

operands = []
outputs = []
current_operator = operators[0]

verticals.each_with_index do |el, i|
  if el.chars.all?(' ')
    outputs << operands.reduce(current_operator)
    operands = []
    current_operator = operators[i + 1]
  else
    operands << el.to_i
  end
end

# Add the final item
outputs << operands.reduce(current_operator)

puts outputs.sum
