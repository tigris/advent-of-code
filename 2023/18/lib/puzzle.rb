# frozen_string_literal: true

require_relative 'helpers'
require 'chunky_png'
require 'set'

# Advent of Code puzzle
class Puzzle
  class << self
    CHANGE_IN_POS = {
      'R' => [0, 1],
      'L' => [0, -1],
      'U' => [-1, 0],
      'D' => [1, 0]
    }

    def part1(input)
      position = [0, 0]
      vectors = []

      total_distance = 0

      input.each_with_index do |instruction, _i|
        direction, distance, = instruction.split(/ /)
        total_distance += distance.to_i

        new_position = [
          position[0] + (CHANGE_IN_POS[direction][0] * distance.to_i),
          position[1] + (CHANGE_IN_POS[direction][1] * distance.to_i)
        ]

        vectors << [position, new_position]

        position = new_position
      end

      # shoelace formula + pick's theorem
      area = vectors.map { |a, b| (a[0] * b[1]) - (b[0] * a[1]) }.sum.abs / 2

      # pick's theorem
      inside = area - (total_distance / 2) + 1

      inside + total_distance
    end

    def part2(input)
      new_input = []
      input.each do |line|
        _, _, color = line.split(/ /)
        distance, direction = color.match(/[(][#](\w{5})(\w)[)]$/).captures
        direction = %w[R D L U][direction.to_i]
        distance = distance.to_i(16)

        new_input << [direction, distance]
      end

      part1(new_input.map { |x| "#{x[0]} #{x[1]} x" })
    end
  end
end
