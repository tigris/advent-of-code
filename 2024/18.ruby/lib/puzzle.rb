# frozen_string_literal: true

require_relative 'helpers'
require 'set'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      coords, matrix = input

      coords = coords.length > 30 ? coords.take(1024) : coords.take(12)
      init_matrix!(matrix, coords)

      max_r = matrix.keys.map { |r, _| r }.max
      max_c = matrix.keys.map { |_, c| c }.max

      best_path = Helpers.traverse_matrix_bfs(
        matrix,
        [0, 0],
        [max_r, max_c],
        proc { |p| p.value == '.' }
      )

      best_path.length - 1
    end

    def part2(input)
      coords, matrix = input

      max_x = matrix.keys.map { |x, _| x }.max
      max_y = matrix.keys.map { |_, y| y }.max

      while (current = coords.shift)
        matrix[current].value = '#'

        best_path = Helpers.traverse_matrix_bfs(
          matrix,
          [0, 0],
          [max_x, max_y],
          proc { |p| p.value == '.' }
        )

        return current if best_path.empty?
      end

      0
    end

    private

    def init_matrix!(matrix, coords)
      matrix.each_value do |p|
        p.value = coords.include?(p.position) ? '#' : '.'
      end
    end
  end
end
