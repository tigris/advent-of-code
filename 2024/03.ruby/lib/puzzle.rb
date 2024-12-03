# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map do |a, b|
        a.to_i * b.to_i
      end.sum
    end

    def part2(input)
      mul = true
      input.scan(/mul\((\d{1,3}),(\d{1,3})\)|(don't)\(\)|(do)\(\)/).map do |a, b, _off, on|
        if mul && a && b
          a.to_i * b.to_i
        else
          mul = on
          0
        end
      end.sum
    end
  end
end
