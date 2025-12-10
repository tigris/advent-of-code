# frozen_string_literal: true
# typed: strict

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    extend T::Sig

    sig { params(_input: T::Array[String]).returns(Integer) }
    def part1(_input)
      0
    end

    sig { params(_input: T::Array[String]).returns(Integer) }
    def part2(_input)
      0
    end
  end
end
