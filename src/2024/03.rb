# frozen_string_literal: true

re = /mul\((\d+),(\d+)\)|(do\(\))|(don't\(\))/

enabled = true
part1 = 0
part2 = 0

ARGF.read.scan(re).each do |command|
  a, b, on, = command

  if a.nil?
    enabled = !on.nil?
    next
  end

  part1 += a.to_i * b.to_i
  part2 += a.to_i * b.to_i if enabled
end

puts part1
puts part2
