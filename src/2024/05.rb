# frozen_string_literal: true

def parse(input)
  r, p = input.split("\n\n")

  rules = Hash.new { |h, k| h[k] = [] }

  r.split.map { _1.split('|') }.each_with_object(rules) do |(k, v), h|
    h[k] << v
  end

  pages = p.split.map { _1.split(',') }

  [rules, pages]
end

def sorter(rules)
  proc { |a, b|
    rules[a].include?(b) ? -1 : 1
  }
end

def ok?(pages, rules)
  pages == pages.sort(&sorter(rules))
end

def middle(arr)
  arr[arr.size / 2]
end

rules, pages = parse(ARGF.read)
correct, incorrect = pages.partition { |p| ok?(p, rules) }

part1 = correct.map { |p| middle(p) }.map(&:to_i).sum
part2 = incorrect.map { |p| p.sort(&sorter(rules)) }.map { |p| middle(p) }.map(&:to_i).sum

puts part1
puts part2
