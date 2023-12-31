# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp).chunk(&:empty?).map { _2 }.reject { |x| x == [''] }
    end
  end
end
