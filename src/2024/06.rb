# frozen_string_literal: true

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

visited = {}

facing = Complex(0, -1)
loc = sp
while map.include? loc
  visited[loc] = true
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

part1 = visited.size

def loops(map, start)
  visited = {}
  loc = start
  facing = Complex(0, -1)

  while map.include? loc
    return true if visited.include? [loc, facing]

    visited[[loc, facing]] = true

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

  false
end

part2 = 0
height.times do |y|
  width.times do |x|
    next if [x, y] == sp

    m = map.dup
    m[[x, y]] = true
    part2 += 1 if loops(m, sp)
  end
end

puts part1
puts part2
