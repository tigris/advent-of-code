# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      map = Helpers.hash_of_points(input).transform_values(&:to_i)
      scores = map.to_h { |k, _v| [k, score(map, k).uniq.size] }
      scores.values.sum
    end

    def part2(input)
      map = Helpers.hash_of_points(input).transform_values(&:to_i)
      scores = map.to_h { |k, _v| [k, score(map, k).size] }
      scores.values.sum
    end

    def score(map, pos, height = 0, searched = [])
      return [pos.dup] if height == 9 && map[pos] == 9
      return [] unless map[pos] == height

      found = []

      [
        [pos[0] - 1, pos[1]],
        [pos[0] + 1, pos[1]],
        [pos[0], pos[1] - 1],
        [pos[0], pos[1] + 1]
      ].each do |new_pos|
        next unless map.key?(new_pos)
        next if searched.include?(new_pos)

        found += score(map, new_pos, height + 1, searched + [pos])
      end

      found = found.reject(&:empty?)
    end
  end
end
