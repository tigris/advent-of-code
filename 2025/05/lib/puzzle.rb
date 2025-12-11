# frozen_string_literal: true
# typed: strict

require 'puzzle/helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    extend T::Sig

    sig { params(input: T::Array[String]).returns(Integer) }
    def part1(input)
      ranges, ingredients = input.slice_before(&:empty?).to_a
      ranges.map! { Helpers.string_to_range(it) }
      ingredients[1..].count { |i| ranges.any? { |range| range.cover?(i.to_i) } }
    end

    sig { params(input: T::Array[String]).returns(Integer) }
    def part2(input)
      ranges = input.slice_before(&:empty?).first
      ranges = Helpers.range_compact(ranges.map { Helpers.string_to_range(it) })
      ranges.sum(&:count)
    end
  end
end
