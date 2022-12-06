# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, count = 4)
      input.chars.each_with_index do |_, i|
        return i + count if input[i..i + count - 1].chars.uniq.size == count
      end
    end

    def part2(input)
      part1(input, 14)
    end
  end
end
