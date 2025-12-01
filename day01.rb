input = File.readlines('data01.txt').map(&:chomp)
# input = 'L68
# L30
# R48
# L5
# R60
# L55
# L1
# L99
# R14
# L82'.lines.map(&:chomp)
turns = input.map { |l| (l[0] == 'L' ? -1 : 1) * l[1..-1].to_i }
zeroes = 0
state = 50

turns.each do |turn|
    state += turn
    state %= 100
    zeroes += 1 if state == 0
end

puts zeroes