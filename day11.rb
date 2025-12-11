input = File.readlines('data11.txt').map(&:chomp)

graph = Hash.new { |h, k| h[k] = [] }
inverse_graph = Hash.new { |h, k| h[k] = [] }

input.each do |line|
  in_edge, *out_edges = line.split
  in_edge = in_edge.gsub(':', '')
  out_edges.each do |out_edge|
    graph[in_edge] << out_edge
    inverse_graph[out_edge] << in_edge
  end
end

def find_all_paths(start, finish, graph, cache = {})
  return 1 if start == finish
  return cache[start] if cache[start]

  cache[start] = graph[start].sum { |next_node| find_all_paths(next_node, finish, graph, cache) }
end

puts find_all_paths('you', 'out', graph)

# Part 2

def dynamically_find_all_paths(start, finish, graph, a, b, has_a = false, has_b = false, cache = {})
  return has_a && has_b ? 1 : 0 if start == finish
  return cache[[start, has_a, has_b]] if cache[[start, has_a, has_b]]

  has_a = true if start == a
  has_b = true if start == b
  
  cache[[start, has_a, has_b]] = graph[start].sum do |next_node|
    dynamically_find_all_paths(next_node, finish, graph, a, b, has_a, has_b, cache)
  end
end

puts dynamically_find_all_paths('svr', 'out', graph, 'fft', 'dac')