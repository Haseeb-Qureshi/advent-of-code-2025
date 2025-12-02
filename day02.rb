input = File.read('data02.txt').chomp

ranges = input.split(',').map do |s|
    Range.new(*s.split('-').map(&:to_i))
end

def invalid_ids_within(range)
    range.select { |n| invalid_id?(n) }
end

def invalid_id?(num)
    s = num.to_s
    s[0...s.length / 2] == s[s.length / 2..-1]
end

puts ranges.sum { |r| invalid_ids_within(r).sum }

# Part 2

def invalid_id?(num)
  s = num.to_s
  1.upto(s.length / 2).any? { |len| s.chars.each_slice(len).uniq.size == 1 }
end

puts ranges.sum { |r| invalid_ids_within(r).sum }


