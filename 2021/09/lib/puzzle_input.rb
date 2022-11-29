# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map { |x| x.chomp.chars.map(&:to_i) }
    end
  end
end
