# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.select { |x, y| x.cover?(y) || y.cover?(x) }.count
    end

    def part2(input)
      input.select { |a, b| b.any? { |x| a.member?(x) } }.count
    end
  end
end
