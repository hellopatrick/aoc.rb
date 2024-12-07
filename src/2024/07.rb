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

  if allow_concat
    vv = v.to_s
    tt = target.to_s
    return true if tt.end_with?(vv) && ok?(tt.chomp(vv).to_i, rest[..-2], allow_concat)
  end

  ok?(target - v, rest[..-2], allow_concat)
end

part1 = puzzle.filter_map do |n, vs|
  n if ok?(n, vs, false)
end.sum

part2 = puzzle.filter_map do |n, vs|
  n if ok?(n, vs, true)
end.sum

raise "part1 wrong" unless part1 == 3_598_800_864_292
raise "part2 wrong" unless part2 == 340_362_529_351_427
