# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      left = input.map { |l| l.gsub(/\s.+$/, '').to_i }.sort
      right = input.map { |l| l.gsub(/^.+\s+/, '').to_i }.sort

      left.each_with_index.map { |l, i| (l - right[i]).abs }.sum
    end

    def part2(input)
      left = input.map { |l| l.gsub(/\s.+$/, '').to_i }
      right = input.map { |l| l.gsub(/^.+\s+/, '').to_i }

      left.map { |l| l * right.count(l) }.sum
    end
  end
end
