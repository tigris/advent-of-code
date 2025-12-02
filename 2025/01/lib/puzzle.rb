# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      positions = []
      input.map { to_i(it) }.inject(50) do |dial, turn|
        dial += turn
        positions << dial
        dial
      end
      positions.select { |x| (x % 100).zero? }.count
    end

    def part2(input)
      positions = []
      input.map { to_i(it) }.inject(50) do |dial, turn|
        dial += turn
        positions << dial
        dial
      end

      ([50] + positions).each_cons(2).map do |a, b|
        distance = [a, b].sort.reduce(:-).abs

        if (a % 100).zero?
          distance / 100
        elsif (b % 100).zero?
          (distance / 100) + 1
        elsif a / 100 != b / 100
          [(a / 100), (b / 100)].sort.reduce(:-).abs
        else
          0
        end
      end.sum
    end

    def to_i(string)
      Integer(string.sub('L', '-').sub('R', ''))
    end
  end
end
