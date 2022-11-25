# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      window_sums = input[0..-3].each_with_index.map { |_, i| input[i..i + 2].sum }
      window_sums[1..].each_with_index.map { |x, i| [x, window_sums[i]] }.select { |x| x[0] > x[1] }.size
    end
  end
end
