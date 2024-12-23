# frozen_string_literal: true

require 'helpers'
require 'rb_heap'

# Path of points in a solution
class PathPoint
  attr_reader :point, :direction, :score, :path

  def initialize(point:, direction:, score:, path: [])
    @point = point
    @direction = direction
    @score = score
    @path = path
  end

  def position
    point.position
  end

  def valid?
    point && point.value != '#'
  end

  def finished?
    point&.value == 'E'
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    DIRECTIONS = %i[up down left right].freeze

    def solutions(matrix)
      start_point = matrix.values.find { |p| p.value == 'S' }
      queue = Heap.new { |a, b| a.score < b.score }
      queue << PathPoint.new(point: start_point, direction: :right, score: 0, path: [])
      visited = {}
      solutions = []

      while (current = queue.pop)
        if current.finished?
          solutions << current
          next
        end

        DIRECTIONS.each do |direction|
          new_point = move(matrix, current, direction)
          next unless new_point.valid?

          state = [new_point.position, direction]
          next if visited[state] && visited[state] < new_point.score

          visited[state] = new_point.score
          queue << new_point
        end
      end

      solutions
    end

    def part1(matrix)
      solutions(matrix).map(&:score).min
    end

    def part2(matrix)
      solutions = solutions(matrix)
      best = solutions.map(&:score).min
      solutions = solutions.select { |s| s.score == best }

      # solutions.each{|s| print_solution(matrix, s)}

      paths = solutions.map { |s| s.path.map(&:first) }.flatten(1)
      paths.uniq.count + 1
    end

    private

    def print_solution(matrix, solution)
      solution.path.each do |point, direction|
        matrix[point].value = case direction
                              when :up
                                '^'
                              when :down
                                'v'
                              else
                                direction == :left ? '<' : '>'
                              end
      end
      Helpers.print_matrix(matrix)
      solution.path.each_key { |point| matrix[point].value = '.' }
    end

    def move(matrix, current, direction)
      next_point = current.point.send(direction, matrix)
      PathPoint.new(
        point: next_point,
        direction: direction,
        score: current.score + (current.direction == direction ? 1 : 1001),
        path: current.path + [[current.position, direction]]
      )
    end
  end
end
