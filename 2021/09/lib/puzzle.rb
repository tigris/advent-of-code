# frozen_string_literal: true

require 'matrix'

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      lowpoints = []

      input.each_with_index do |row, y|
        row.each_with_index do |val, x|
          lowpoints << val if lowpoint?(val, input, x, y)
        end
      end

      lowpoints.sum + lowpoints.size
    end

    def lowpoint?(val, input, x, y)
      around = []
      around << input[y][x - 1] if x.positive?
      around << input[y][x + 1] if x < input[y].length - 1
      around << input[y - 1][x] if y.positive?
      around << input[y + 1][x] if y < input.length - 1

      val < around.min
    end
  end
end
