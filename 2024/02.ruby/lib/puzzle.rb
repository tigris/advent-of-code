# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      reports = input.map { |line| line.split.map(&:to_i) }
      reports.count { |report| valid_report?(report) }
    end

    def part2(input)
      reports = input.map { |line| line.split.map(&:to_i) }
      reports.count { |report| valid_report_with_one_removed?(report) }
    end

    def valid_report?(report)
      report = report.reverse if report[0] > report[-1]
      report[1..].each_with_index.all? { |num, i| (num - report[i]).between?(1, 3) }
    end

    def valid_report_with_one_removed?(report)
      return true if valid_report?(report)

      report.length.times.any? do |i|
        left = report.slice(0, i)
        right = report.slice(i + 1, report.length)
        valid_report?(left + right)
      end
    end
  end
end
