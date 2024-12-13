# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self

    def part1(input)
      matrix = Helpers.hash_of_points(input)
      cached_areas = {}
      cached_fences = {}

      matrix.reduce(0) do |total, (point, value)|
        cached_areas[point] ||= area(matrix, point)
        cached_fences[point] ||= fence(matrix, point)

        total + cached_areas[point] * cached_fences[point]
      end
    end

    def part2(_input)
      nil
    end

    private

    def area(matrix, point)
      return 0 if matrix[point].nil?

      visited = Set.new
      queue = [point]

      while queue.any?
        current = queue.pop
        next if visited.include?(current)

        visited << current

        Helpers.around(current).each do |neighbor|
          queue << neighbor if !visited.include?(neighbor) && matrix[neighbor] == matrix[point]
        end
      end

      visited.size
    end

    def fence(matrix, point)
      return 0 if matrix[point].nil?

      Helpers.around(point).count { |neighbor| matrix[neighbor] != matrix[point] }
    end
  end
end
