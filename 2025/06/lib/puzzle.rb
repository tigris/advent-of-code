# frozen_string_literal: true
# typed: strict

require 'puzzle/helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    extend T::Sig

    sig { params(input: T::Array[String]).returns(Integer) }
    def part1(input)
      numbers = T.must(input[0..-2]).map { it.split.map(&:to_i) }
      operations = T.must(input.last).split.map(&:to_sym)

      operations.map.with_index do |op, i|
        numbers.map { it[i] }.reduce(op)
      end.sum
    end

    sig { params(_input: T::Array[String]).returns(Integer) }
    def part2(_input)
      0
    end
  end
end
