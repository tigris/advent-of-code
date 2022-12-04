# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp).map do |l|
        l.split(/,/).map do |x|
          a, b = x.split(/-/)
          Range.new(a.to_i, b.to_i)
        end
      end
    end
  end
end
