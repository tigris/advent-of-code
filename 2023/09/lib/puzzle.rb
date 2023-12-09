# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.map{|x| next_in_sequence(x) }.sum
    end

    def next_in_sequence(numbers)
      return 0 if numbers.uniq == [0]
      numbers.last + next_in_sequence(numbers[1..].map.with_index{|n, i| n - numbers[i] })
    end

    def part2(input)
      part1(input.map(&:reverse))
    end
  end
end
