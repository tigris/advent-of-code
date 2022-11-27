# frozen_string_literal: true

require 'matrix'
require 'line'

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      max_width  = input.flatten.map { |v| v[0] }.max + 1
      max_height = input.flatten.map { |v| v[1] }.max + 1

      vents = Matrix.build(max_width, max_height) { 0 }
      lines = input.map { |line| Line.new(line[0], line[1]) }.select { |l| l.horizontal? or l.vertical? }

      lines.each do |line|
        line.points.each do |point|
          vents[point[1], point[0]] += 1
        end
      end

      vents.to_a.flatten.select { |c| c >= 2 }.length
    end
  end
end
