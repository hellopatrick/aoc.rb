# frozen_string_literal: true

reports = ARGF.readlines.map(&:split).map { |report| report.map(&:to_i) }

def safe?(report)
  changes = report.each_cons(2).map { |a, b| b - a }

  changes.all? { |a| [1, 2, 3].include? a } || changes.all? { |a| [-1, -2, -3].include? a }
end

def fixable?(report)
  (0...report.size).any? do |i|
    report_dup = report.dup
    report_dup.delete_at(i)

    safe? report_dup
  end
end

puts reports.filter { |report| safe?(report) }.size
puts reports.filter { |report| safe?(report) || fixable?(report) }.size
