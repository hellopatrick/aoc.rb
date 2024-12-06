# frozen_string_literal: true

require 'set'

sp = [0, 0]
input = ARGF.readlines

input.size
input[0].strip.size

map = input.each_with_index.map do |row, y|
  row.strip.chars.each_with_index.map do |c, x|
    sp = [x, y] if c == '^'
    [[x, y], c == '#']
  end
end.flatten(1).to_h

def travel(map, start)
  visited = Set.new

  loc = start
  facing = Complex(0, -1)

  res = :exit

  while map.include? loc
    if visited.include? [loc, facing]
      res = :loop
      break
    end

    visited.add [loc, facing]

    x, y = loc
    dx, dy = facing.rect

    nx = x + dx
    ny = y + dy

    if map[[nx, ny]]
      facing *= Complex(0, 1)
    else
      loc = [nx, ny]
    end
  end

  [res, visited.map { _1[0] }.uniq]
end

_, part1 = travel(map, sp)

part2 = part1.filter do |k|
  if k == sp
    false
  else
    m = map.dup
    m[k] = true
    res, = travel(m, sp)
    res == :loop
  end
end

puts part1.size
puts part2.size
