# frozen_string_literal: true

require 'helpers'

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      lines = File.readlines(file).map(&:chomp)

      small_input = ['.' * 7] * 7
      big_input = ['.' * 71] * 71

      matrix = Puzzle::Helpers.hash_of_points(lines.length > 30 ? big_input : small_input)

      coords = lines.map do |line|
        line.match(/^(\d+),(\d+)$/).captures.map(&:to_i)
      end

      [coords, matrix]
    end
  end
end
