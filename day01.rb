input = File.readlines('data01.txt').map(&:chomp)
turns = input.map { |l| (l[0] == 'L' ? -1 : 1) * l[1..-1].to_i }

zeroes = 0
state = 50

turns.each do |turn|
    state += turn
    state %= 100
    zeroes += 1 if state == 0
end

puts zeroes

# Part 2

zeroes = 0
state = 50

turns.each do |turn|
    state += turn

    if state <= 0
        if state == turn # started on zero
            zeroes += state.abs / 100
        else
            zeroes += (state / 100).abs
        end
        zeroes += 1 if state % 100 == 0
    elsif state > 99
        zeroes += state / 100
    end

    state %= 100
end

puts zeroes