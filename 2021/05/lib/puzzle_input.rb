# frozen_string_literal: true

require 'matrix'

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map do |line|
        line.chomp.split(/ -> /).map do |vectors|
          x, y = vectors.split(',').map(&:to_i)
          Vector[x, y]
        end
      end
    end
  end
end
