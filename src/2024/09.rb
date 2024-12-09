# frozen_string_literal: true

require 'set'

INPUT = ARGF.read.strip

def parse(input)
  input.chars.map(&:to_i).each_with_index.filter_map do |v, i|
    if v.zero?
      nil
    elsif i.even?
      [i / 2, v]
    else
      [-1, v]
    end
  end
end

def compart_part1(data)
  loop do
    i = data.rindex { |block| block[0] != -1 && block[1].positive? }
    j = data.index { |block| block[0] == -1 && block[1].positive? }

    break if j.nil? || i.nil? || j >= i

    id, size = data[i]
    _, free = data[j]

    moved = free > size ? size : free

    data[i][1] -= moved
    data[j][1] -= moved

    data.insert(j, [id, moved])
  end

  data
end

def compart_part2(data)
  attempted = Set.new([-1])

  loop do
    i = data.rindex { |block| !attempted.include?(block[0]) && block[1].positive? }
    break if i.nil?

    id, size = data[i]
    attempted.add id

    j = data.index { |block| block[0] == -1 && block[1] >= size }

    next if j.nil? || j >= i

    attempted.add id

    _, free = data[j]

    next if size > free

    data[i][0] = -1
    data[j][1] -= size

    data.insert(j, [id, size])
  end

  data
end

def checksum(data)
  sum = 0
  idx = 0

  data.each do |id, n|
    n.times do
      sum += id * idx if id != -1
      idx += 1
    end
  end

  sum
end

puts checksum(compart_part1(parse(INPUT)))
puts checksum(compart_part2(parse(INPUT)))
