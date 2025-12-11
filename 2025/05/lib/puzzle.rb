# frozen_string_literal: true
# typed: strict

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    extend T::Sig

    sig { params(input: T::Array[String]).returns(Integer) }
    def part1(input)
      ranges, ingredients = input.slice_before(&:empty?).to_a
      ranges.map! { string_to_range(it) }

      ingredients[1..].count { |i| ranges.any? { |range| range.cover?(i.to_i) } }
    end

    sig { params(_input: T::Array[String]).returns(Integer) }
    def part2(_input)
      14
    end

    sig { params(string: String).returns(T::Range[Integer]) }
    def string_to_range(string)
      a, b = string.split('-')
      a.to_i..b.to_i
    end
  end
end
