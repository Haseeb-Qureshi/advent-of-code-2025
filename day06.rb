input = "123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  ".lines
input = File.readlines('data06.txt')

input = input.map(&:split)
sum = input.transpose.sum do |line|
  line[0..-2].map(&:to_i).reduce(line.last)
end

puts sum