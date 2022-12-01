# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp).chunk(&:empty?).map { |x, y| x ? nil : y.map(&:to_i) }.compact
    end
  end
end
