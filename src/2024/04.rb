# frozen_string_literal: true

puzzle = ARGF.readlines.map { |l| l.strip.chars }

def xmas?(puzzle, x, y, dx, dy)
  height = puzzle.size
  width = puzzle[0].size

  'XMAS'.each_char.with_index do |char, index|
    xi = x + (dx * index)
    yi = y + (dy * index)

    return false if xi < 0 || xi >= width
    return false if yi < 0 || yi >= height
    return false if puzzle[yi][xi] != char
  end

  true
end

def x_mas?(puzzle, x, y)
  height = puzzle.size
  width = puzzle[0].size

  return false if x - 1 < 0 || y - 1 < 0 || x + 1 >= width || y + 1 >= height
  return false unless puzzle[y][x] == 'A'

  diagonals = [
    [puzzle[y - 1][x - 1], puzzle[y + 1][x + 1]],
    [puzzle[y - 1][x + 1], puzzle[y + 1][x - 1]]
  ]

  diagonals.all? do |a, b|
    (a == 'S' && b == 'M') || (a == 'M' && b == 'S')
  end
end

height = puzzle.size
width = puzzle[0].size

part1 = 0
part2 = 0
height.times do |y|
  width.times do |x|
    part1 += 1 if xmas?(puzzle, x, y, 0, 1)
    part1 += 1 if xmas?(puzzle, x, y, 1, 1)
    part1 += 1 if xmas?(puzzle, x, y, 1, 0)
    part1 += 1 if xmas?(puzzle, x, y, 1, -1)
    part1 += 1 if xmas?(puzzle, x, y, 0, -1)
    part1 += 1 if xmas?(puzzle, x, y, -1, -1)
    part1 += 1 if xmas?(puzzle, x, y, -1, 0)
    part1 += 1 if xmas?(puzzle, x, y, -1, 1)
    part2 += 1 if x_mas?(puzzle, x, y)
  end
end

puts "part1: #{part1}"
puts "part2: #{part2}"
