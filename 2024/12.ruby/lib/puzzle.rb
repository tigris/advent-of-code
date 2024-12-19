# frozen_string_literal: true

require_relative 'helpers'
require 'securerandom'

# data class to hold the point and its values
class Point < Puzzle::Point
  attr_accessor :plot, :fence_left, :fence_right, :fence_above, :fence_below

  def initialize(position, value)
    super

    @fence_left = nil
    @fence_right = nil
    @fence_above = nil
    @fence_below = nil
  end

  def fences
    [fence_left, fence_right, fence_above, fence_below].count(&:itself)
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      price(build_matrix(input))
    end

    def part2(input)
      matrix = build_matrix(input)
      discount_fences!(matrix)
      price(matrix)
    end

    private

    def price(matrix)
      matrix.values.uniq(&:plot).reduce(0) do |price, plot|
        plot_points = matrix.values.select { |point| point.plot == plot.plot }
        area = plot_points.size
        fence = plot_points.map(&:fences).sum
        price + (area * fence)
      end
    end

    def build_matrix(input)
      matrix = Helpers.hash_of_points(input) { |row, col, val| ::Point.new([row, col], val) }

      matrix.each_value do |current|
        next if current.plot

        Helpers.traverse_matrix_bfs(matrix, current) do |n|
          calculate!(matrix, n) if n.value == current.value
        end
      end

      matrix
    end

    def discount_fences!(matrix)
      matrix.each_value do |point|
        left = point.left(matrix)
        right = point.right(matrix)
        above = point.above(matrix)
        below = point.below(matrix)

        if right&.plot == point.plot
          point.fence_above = nil if right.fence_above && point.fence_above

          point.fence_below = nil if right.fence_below && point.fence_below
        end

        if left&.plot == point.plot
          point.fence_above = nil if left.fence_above && point.fence_above

          point.fence_below = nil if left.fence_below && point.fence_below
        end

        if above&.plot == point.plot
          point.fence_left = nil if above.fence_left && point.fence_left

          point.fence_right = nil if above.fence_right && point.fence_right
        end

        next unless below&.plot == point.plot

        point.fence_left = nil if below.fence_left && point.fence_left

        point.fence_right = nil if below.fence_right && point.fence_right
      end
    end

    def calculate!(matrix, point)
      left = point.left(matrix)
      right = point.right(matrix)
      above = point.above(matrix)
      below = point.below(matrix)

      around = [left, right, above, below].compact

      point.plot = if (plot_neighbour = around.find { |p| p.value == point.value && p.plot })
                     # We're in the same plot as our neighbour
                     plot_neighbour.plot
                   else
                     # We're in a new plot
                     SecureRandom.uuid
                   end

      point.fence_left = left&.value != point.value
      point.fence_right = right&.value != point.value
      point.fence_above = above&.value != point.value
      point.fence_below = below&.value != point.value

      true
    end
  end
end
