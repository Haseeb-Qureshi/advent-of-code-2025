require 'rb_heap'
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

# Part 2


# ANSWER:
# 
# IT'S A LINEAR PROGRAMMING PROBLEM, YOU NEED TO USE A LINEAR PROGRAMMING LIBRARY TO FIND A FIXED INTEGER MULTIPLE OF EACH BUTTON TO GET THE OUTPUT

def distance(a, b)
  a.zip(b).sum { |a, b| a - b }
end

# def fewest_presses_from(current_state, final_state, toggles)
#   _fewest_presses_from(current_state, final_state, toggles.sort_by(&:length))
# end

# def _fewest_presses_from(current_state, final_state, toggles, dead_ends = Set.new, current_count = 0, toggles_so_far = [])
#   return Float::INFINITY if dead_ends.include?(current_state)
#   return Float::INFINITY if current_state.zip(final_state).any? { |a, b| a > b }
#   return current_count if current_state == final_state

#   # try each subsequent button and see if they work
#   res = Float::INFINITY
  
#   toggles.each do |toggle|
#     new_state = current_state.dup
#     toggle.each { |i| new_state[i] += 1 }
#     res = _fewest_presses_from(new_state, final_state, toggles, dead_ends, current_count + 1, toggles_so_far + [toggle])
#     return res if res < Float::INFINITY
#   end
#   res
# end

def max_dist(a, b)
  b.max - a.max
end

def fewest_presses_from(initial_state, final_state, toggles)
  queue = Heap.new { |a, b| a[-1] < b[-1] }
  queue << [initial_state, 0, max_dist(initial_state, final_state)]
  # queue = [[initial_state, 0]]
  seen = Set.new
  toggles = toggles.sort_by(&:length).reverse
  
  until queue.empty?
    state, presses_so_far, heuristic_dist = queue.pop # dijkstra's in a way that optimizes for manhattan distance
    return presses_so_far if state == final_state
    # require 'pry'; binding.pry if queue.size > 60 * 6
    
    # TODO: Need to update if shorter path
    next if seen.include?(state)
    seen << state
    
    next if state.zip(final_state).any? { |a, b| a > b }
    p [queue.peak, final_state, state.zip(final_state).map { |a, b| b - a }]

    toggles.each do |toggle|
      new_state = state.dup
      toggle.each { |i| new_state[i] += 1 }
      queue << [new_state, presses_so_far + 1, presses_so_far + max_dist(new_state, final_state)]
    end
  end
end

total_presses = 0
fewests = input.map.with_index do |line, i|
  _, *toggles, presses = line.split
  
  toggles = toggles.map { |s| s[1...-1].split(',').map(&:to_i) }
  final_state = presses[1...-1].split(',').map(&:to_i)

  current_state = [0] * final_state.size
  p i
  p fewest_presses_from(current_state, final_state, toggles)
end

puts fewests.sum