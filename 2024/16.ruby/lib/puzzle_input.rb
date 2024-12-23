# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  # Convert given file into ruby data structure
  class Input
    class << self
      def call(file)
        Helpers.hash_of_points(File.readlines(file).map(&:chomp))
      end
    end
  end
end
