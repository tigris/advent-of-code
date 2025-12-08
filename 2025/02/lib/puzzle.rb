# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      ranges = input[0].split(',').map{ a, b = it.split('-') ; a.to_i .. b.to_i }

      matches = {}
      ranges.each do |range|
        range.each do
          if matches.key?(it)
            matches[it] += 1 if matches[it].positive?
            next
          end

          chars = it.to_s.chars
          half  = chars.length / 2
          front = chars[0 ... half]
          back  = chars[half ..]

          matches[it] = front == back ? 1 : 0
        end
      end

      matches.map{|k, v| k * v }.sum
    end

    def part2(input)
      nil
    end
  end
end
