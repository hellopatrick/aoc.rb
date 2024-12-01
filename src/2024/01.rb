# frozen_string_literal: true

pairs = ARGF.readlines.map(&:split).transpose

left = pairs[0].map(&:to_i).sort
right = pairs[1].map(&:to_i).sort

counts = right.tally
counts.default = 0

puts left.zip(right).map { |a, b| (a - b).abs }.sum
puts left.map { |l| l * counts[l] }.sum
