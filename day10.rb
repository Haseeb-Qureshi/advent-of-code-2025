input = File.readlines('data10.txt').map(&:chomp)

def turn_to_binary(len, arr)
  arr.reduce(0) { |acc, i| acc += 2 ** (len - i - 1) }
end

total_presses = 0
input.each do |line|
  lights, *toggles, _ = line.split

  lights = lights[1...-1]
  on_toggles = lights.chars.filter_map.each_with_index { |c, i| i if c == '#' }
  lights_num = turn_to_binary(lights.length, on_toggles)
  
  toggle_nums = toggles.map { |s| turn_to_binary(lights.length, s[1...-1].split(',').map(&:to_i)) }

  total_presses += 1.upto(toggle_nums.length).find do |n|
    toggle_nums.combination(n).any? { |arr| arr.reduce(:^) == lights_num }
  end
end

puts total_presses

# Part 2

# IT'S A LINEAR PROGRAMMING PROBLEM, YOU NEED TO USE A LINEAR PROGRAMMING LIBRARY TO FIND A FIXED INTEGER MULTIPLE OF EACH BUTTON TO GET THE OUTPUT
require 'rulp'
ENV['SOLVER'] = 'cbc'
Rulp.log_level = Logger::WARN

fewests = input.map.with_index do |line, i|
  _, *toggles, presses = line.split
  
  toggles = toggles.map { |s| s[1...-1].split(',').map(&:to_i) }
  final_state = presses[1...-1].split(',').map(&:to_i)

  variables = toggles.map.with_index { |_, i| Toggle_i(i) }
  toggles_to_variables = toggles.zip(variables).to_h

  problem = Rulp::Min(variables.reduce(:+))
  
  final_state.each_index do |i|
    vars = toggles_to_variables.values_at(*toggles.select { |t| t.include?(i) })
    problem[vars.map { |v| v * 1 }.reduce(:+) == final_state[i]]
  end
  problem.solve
  variables.map(&:value).sum
end

puts fewests.compact.sum.to_i