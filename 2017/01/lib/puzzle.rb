# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input = input.first
      input << input.first
      input.each_with_index.map { |x, i| x == input[i + 1] ? x : 0 }.sum
    end

    def part2(input)
      input = input.first
      front = input.slice(0, input.size / 2)
      back  = input.slice(front.size, front.size)
      front.each_with_index.map { |x, i| x == back[i] ? x * 2 : 0 }.sum
    end
  end
end
