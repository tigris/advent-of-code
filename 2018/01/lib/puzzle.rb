# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.sum
    end

    def part2(input)
      found = []
      loop do
        input.each do |i|
          current = (found.last || 0) + i
          return current if found.include?(current)

          found << current
        end
      end
    end
  end
end
