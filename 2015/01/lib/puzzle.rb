# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.map { |x| x.scan('(').size - x.scan(')').size }
    end

    def part2(input)
      input.map do |x|
        c = nil
        floor = 0
        x.scan(/./).each_with_index do |y, i|
          next if c

          floor += y == '(' ? 1 : -1
          c = i + 1 if floor == -1
        end
        c
      end
    end
  end
end
