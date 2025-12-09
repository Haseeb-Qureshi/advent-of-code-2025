input = '162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689'.lines.map(&:chomp)
input = File.readlines('data08.txt').map(&:chomp)

# create edges & circuits
Box = Struct.new(:x, :y, :z)
class Box
  def dist_to(box2)
    (x - box2.x).abs ** 2 + (y - box2.y).abs ** 2 + (z - box2.z).abs ** 2
  end
end

boxes = input.map do |l|
  Box.new(*l.split(',').map(&:to_i))
end

distances = []
boxes.combination(2).each do |b1, b2|
  distances << [b1, b2, b1.dist_to(b2)]  
end

distances.sort_by!(&:last)

connections = Hash.new { |h, k| h[k] = Set.new }
CLOSEST_CONNECTIONS = 1000

# Find ten closest connections
CLOSEST_CONNECTIONS.times do 
  b1, b2, _ = distances.shift
  connections[b1] << b2
  connections[b2] << b1
end

def connected_components(graph, connections)
  seen = Set.new
  circuits = []

  graph.each do |b|
    next if seen.include?(b)
    circuits << dfs!(b, seen, connections)
  end
  circuits
end

def dfs!(b, seen, connections)
  return [] if seen.include?(b)
  seen << b

  circuit = [b]
  connections[b].each do |b2|
    circuit += dfs!(b2, seen, connections)
  end
  circuit
end

require 'pry-byebug'
circuits = connected_components(boxes, connections)
puts circuits.map(&:length).sort.last(3).reduce(:*)