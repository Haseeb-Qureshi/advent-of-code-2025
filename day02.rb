input = File.read('data02.txt').chomp
# input = '11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124'.chomp

ranges = input.split(',').map do |s|
    Range.new(*s.split('-').map(&:to_i))
end

def invalid_ids_within(range)
    range.select { |n| invalid_id?(n) }
end

def invalid_id?(num)
    s = num.to_s
    return false if s.length.odd?
    s[0...s.length / 2] == s[s.length / 2..-1]
end

puts ranges.sum { |r| invalid_ids_within(r).sum }