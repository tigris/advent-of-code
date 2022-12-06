# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.each_with_index do |e, i1|
        (i1 + 1..input.length - 1).each do |i2|
          return e * input[i2] if e + input[i2] == 2020
        end
      end
    end

    def part2(input)
      input.each_with_index do |e, i1|
        (i1 + 1..input.length - 1).each do |i2|
          (i2 + 1..input.length - 1).each do |i3|
            return e * input[i2] * input[i3] if e + input[i2] + input[i3] == 2020
          end
        end
      end
    end
  end
end
