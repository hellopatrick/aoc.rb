# frozen_string_literal: true

stones = ARGF.read.strip.split.map(&:to_i)

class Solver
  @cache = {}

  def solve(stone, steps)
    @cache ||= {}

    return @cache[[stone, steps]] if @cache[[stone, steps]]

    return 1 if steps.zero?
    return solve(1, steps - 1) if stone.zero?

    s = stone.to_s

    @cache[[stone, steps]] ||= if s.size.even?
                                 solve(s[0...s.size / 2].to_i, steps - 1) + solve(s[s.size / 2..].to_i, steps - 1)
                               else
                                 solve(stone * 2024, steps - 1)
                               end
  end
end

solver = Solver.new

part1 = stones.each_with_object(solver).map { |stone, s| s.solve(stone, 25) }.sum
part2 = stones.each_with_object(solver).map { |stone, s| s.solve(stone, 75) }.sum

raise 'wrong part one' unless part1 == 203_609
raise 'wrong part two' unless part2 == 240_954_878_211_138

puts part1
puts part2
