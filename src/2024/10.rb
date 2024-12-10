# frozen_string_literal: true

lines = ARGF.readlines.map { |row| row.strip.chars.map(&:to_i) }

grid = {}

lines.each_with_index do |row, y|
  row.each_with_index do |c, x|
    grid[[x, y]] = c
  end
end

part1 = 0
part2 = 0
grid.each_pair do |sp, h|
  next if h != 0

  q = [sp]

  v = Set.new

  until q.empty?
    p = q.shift
    x, y = p
    val = grid[p]

    part2 += 1 if grid[p] == 9
    part1 += 1 if grid[p] == 9 && !v.include?(p)

    v.add(p)

    q.unshift [x + 1, y] if grid[[x + 1, y]] == val + 1
    q.unshift [x - 1, y] if grid[[x - 1, y]] == val + 1
    q.unshift [x, y + 1] if grid[[x, y + 1]] == val + 1
    q.unshift [x, y - 1] if grid[[x, y - 1]] == val + 1
  end
end

puts part1
puts part2
