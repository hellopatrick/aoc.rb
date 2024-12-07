# frozen_string_literal: true

def parse(input)
  input.map do |l|
    n, vs = l.split(':')

    [n.to_i, vs.strip.split.map(&:to_i)]
  end
end

lines = ARGF.readlines.map(&:strip)

puzzle = parse(lines)

def ok?(target, rest, allow_concat)
  return target == rest.first if rest.size == 1

  v = rest[-1]

  return true if target % v == 0 && ok?(target / v, rest[..-2], allow_concat)

  if allow_concat && target.to_s.end_with?(v.to_s) && ok?(target.to_s[...-v.to_s.size].to_i, rest[..-2], allow_concat)
    return true
  end

  ok?(target - v, rest[..-2], allow_concat)
end

part1 = puzzle.filter_map do |n, vs|
  n if ok?(n, vs, false)
end.sum

part2 = puzzle.filter_map do |n, vs|
  n if ok?(n, vs, true)
end.sum

puts part1
puts part2
