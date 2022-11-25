# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      prev = input[0]
      count = 0

      input[1..-1].each do |item|
        count += 1 if item > prev
        prev = item
      end

      count
    end
  end
end
