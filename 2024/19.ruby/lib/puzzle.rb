# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      towels = input[0].split(', ')
      patterns = input[2..]
      cache = {}

      patterns.count { |p| solutions(p, towels, cache).positive? }
    end

    def part2(input)
      towels = input[0].split(', ')
      patterns = input[2..]
      cache = {}

      patterns.sum { |p| solutions(p, towels, cache) }
    end

    private

    def solutions(pattern, towels, cache)
      return 1 if pattern.empty?
      return cache[pattern] if cache.key?(pattern)

      cache[pattern] = (1..pattern.size).map do |i|
        start = pattern[...i]
        finish = pattern[i..]
        towels.include?(start) ? solutions(finish, towels, cache) : 0
      end.sum
    end
  end
end
