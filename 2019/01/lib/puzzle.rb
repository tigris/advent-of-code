# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.map { |x| (x / 3).round - 2 }.sum
    end

    def part2(input)
      fuel = 0
      input.each do |mass|
        loop do
          req = part1([mass])
          break if req <= 0

          fuel += req
          mass = req
        end
      end
      fuel
    end
  end
end
