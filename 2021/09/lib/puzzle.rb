# frozen_string_literal: true

require 'matrix'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      lowpoints = []

      input.each_with_index do |row, r|
        row.each_with_index do |val, c|
          lowpoints << val if lowpoint?(val, input, r, c)
        end
      end

      lowpoints.sum + lowpoints.size
    end

    def part2(input)
      basins = []

      input.each_with_index do |row, r|
        row.each_with_index do |val, c|
          next unless lowpoint?(val, input, r, c)

          basins << basin(input, r, c)
        end
      end

      basins.sort_by(&:size).last(3).map(&:size).reduce(:*)
    end

    def point_at(input, point)
      r, c = point.split(',')
      input[r][c]
    end

    def basin(input, r, c)
      points = { [r, c] => input[r][c] }

      loop do
        new_points = {}
        points.each_key do |r1, c1|
          new_points.merge!(around(input, r1, c1).reject { |_k, v| v == 9 })
        end
        break if new_points.keys - points.keys == []

        points.merge!(new_points)
      end

      points
    end

    def around(input, r, c)
      around = {}
      around[[r, c - 1]] = input[r][c - 1] if c.positive?
      around[[r, c + 1]] = input[r][c + 1] if c < input[r].length - 1
      around[[r - 1, c]] = input[r - 1][c] if r.positive?
      around[[r + 1, c]] = input[r + 1][c] if r < input.length - 1
      around
    end

    def lowpoint?(val, input, r, c)
      val < around(input, r, c).values.min
    end
  end
end
