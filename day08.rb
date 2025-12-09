input = File.readlines('data08.txt').map(&:chomp)

Box = Struct.new(:x, :y, :z)
class Box
  def dist_to(box2)
    (x - box2.x).abs ** 2 + (y - box2.y).abs ** 2 + (z - box2.z).abs ** 2
  end
end

boxes = input.map { |l| Box.new(*l.split(',').map(&:to_i)) }
distances = []
boxes.combination(2).each do |b1, b2|
  distances << [b1, b2, b1.dist_to(b2)]  
end

distances.sort_by!(&:last)

class Circuit < Set; end

circuits = Hash.new { |h, k| h[k] = Circuit.new }

CLOSEST_CONNECTIONS = 1000
CLOSEST_CONNECTIONS.times do 
  b1, b2, _ = distances.shift
  circuit = Circuit.new([b1, b2]) | circuits[b1] | circuits[b2]
  circuits[b1].each { |b| circuits[b] = circuit }
  circuits[b2].each { |b| circuits[b] = circuit }

  circuits[b1] = circuit
  circuits[b2] = circuit
end

puts circuits.values.uniq.map(&:size).sort.last(3).reduce(:*)

# Part 2

last_two_boxes = []
biggest_circuit = circuits.values.max_by(&:size)
until biggest_circuit.size == boxes.count
  b1, b2, _ = distances.shift
  last_two_boxes = [b1, b2]
  circuit = Circuit.new([b1, b2]) | circuits[b1] | circuits[b2]
  circuits[b1].each { |b| circuits[b] = circuit }
  circuits[b2].each { |b| circuits[b] = circuit }

  circuits[b1] = circuit
  circuits[b2] = circuit
  biggest_circuit = [biggest_circuit, circuit].max_by(&:size)
end

p last_two_boxes.map(&:x).reduce(:*)