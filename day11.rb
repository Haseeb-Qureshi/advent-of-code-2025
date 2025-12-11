input = 'aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out'.lines
input = File.readlines('data11.txt').map(&:chomp)

graph = Hash.new { |h, k| h[k] = [] }

input.each do |line|
  in_edge, *out_edges = line.split
  in_edge = in_edge.gsub(':', '')
  out_edges.each do |out_edge|
    graph[in_edge] << out_edge
  end
end

def find_all_paths(start, finish, graph)
  queue = [[start, []]]
  seen = Set.new
  paths = 0

  until queue.empty?
    cur, path = queue.shift
    next if seen.include?([cur, path])
    seen << [cur, path]
    
    if cur == finish
      paths += 1
      next
    end
    
    graph[cur].each do |next_node|
      require 'pry-byebug'; binding.pry unless path
      queue << [next_node, path + [next_node]]
    end
  end

  paths
end

pp graph
puts find_all_paths('you', 'out', graph)