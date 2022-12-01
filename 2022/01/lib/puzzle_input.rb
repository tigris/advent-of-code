# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp).chunk(&:empty?).map { |_, x| x }.reject { |x| x == [''] }.map { |x| x.map(&:to_i) }
    end
  end
end
