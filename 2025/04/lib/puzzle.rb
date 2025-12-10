# frozen_string_literal: true
# typed: strict

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    extend T::Sig

    sig { params(input: T::Array[String]).returns(Integer) }
    def part1(input)
      map = Helpers.hash_of_points(input)

      movable = map.select { _2.value == '@' && _2.around(map, diagonal: true).count { it.value == '@' } < 4 }

      movable.size
    end

    sig { params(_input: T::Array[String]).returns(Integer) }
    def part2(_input)
      0
    end
  end
end
