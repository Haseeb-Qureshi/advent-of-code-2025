input = File.readlines('data10.txt').map(&:chomp)
# input = '[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
# [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
# [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}'.lines

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