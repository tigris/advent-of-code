# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      points = Helpers.hash_of_points(input)
      points.map { |(r, c), _| matches(points, r, c, 'XMAS').size }.sum
    end

    def part2(input)
      points = Helpers.hash_of_points(input)
      points.select { |(r, c), _| xmas(points, r, c) }.size
    end

    def xmas(points, r, c)
      return false unless points[[r, c]] == 'A'

      max_r = points.keys.map(&:first).max
      max_c = points.keys.map(&:last).max
      return false if r.zero? || c.zero? || r == max_r || c == max_c

      return true if points[[r - 1, c - 1]] == 'M' && points[[r + 1, c + 1]] == 'S' && points[[r - 1, c + 1]] == 'M' && points[[r + 1, c - 1]] == 'S'
      return true if points[[r - 1, c - 1]] == 'M' && points[[r + 1, c + 1]] == 'S' && points[[r - 1, c + 1]] == 'S' && points[[r + 1, c - 1]] == 'M'

      return true if points[[r - 1, c - 1]] == 'S' && points[[r + 1, c + 1]] == 'M' && points[[r - 1, c + 1]] == 'M' && points[[r + 1, c - 1]] == 'S'
      return true if points[[r - 1, c - 1]] == 'S' && points[[r + 1, c + 1]] == 'M' && points[[r - 1, c + 1]] == 'S' && points[[r + 1, c - 1]] == 'M'

      false
    end

    def matches(points, r, c, word)
      max_r = points.keys.map(&:first).max
      max_c = points.keys.map(&:last).max
      matches = []
      return matches if points[[r, c]] != word[0]

      matches << :left_to_right if c <= max_c - 3 && [points[[r, c]], points[[r, c + 1]], points[[r, c + 2]], points[[r, c + 3]]].join == (word)

      matches << :top_to_bottom if r <= max_r - 3 && [points[[r, c]], points[[r + 1, c]], points[[r + 2, c]], points[[r + 3, c]]].join == (word)

      matches << :right_to_left if c >= 3 && [points[[r, c]], points[[r, c - 1]], points[[r, c - 2]], points[[r, c - 3]]].join == (word)

      matches << :bottom_to_top if r >= 3 && [points[[r, c]], points[[r - 1, c]], points[[r - 2, c]], points[[r - 3, c]]].join == (word)

      # diagonal top-left to bottom-right
      matches << :diagonal_top_left_to_bottom_right if r <= max_r - 3 && c <= max_c - 3 && [points[[r, c]], points[[r + 1, c + 1]], points[[r + 2, c + 2]], points[[r + 3, c + 3]]].join == (word)

      # diagonal top-right to bottom-left
      matches << :diagonal_top_right_to_bottom_left if r <= max_r - 3 && c >= 3 && [points[[r, c]], points[[r + 1, c - 1]], points[[r + 2, c - 2]], points[[r + 3, c - 3]]].join == (word)

      # diagonal bottom-left to top-right
      matches << :diagonal_bottom_left_to_top_right if r >= 3 && c <= max_c - 3 && [points[[r, c]], points[[r - 1, c + 1]], points[[r - 2, c + 2]], points[[r - 3, c + 3]]].join == (word)

      # diagonal bottom-right to top-left
      matches << :diagonal_bottom_right_to_top_left if r >= 3 && c >= 3 && [points[[r, c]], points[[r - 1, c - 1]], points[[r - 2, c - 2]], points[[r - 3, c - 3]]].join == (word)

      matches
    end
  end
end
