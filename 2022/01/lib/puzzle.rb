# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      # input.map{|x| x.sum}.max
      input.map(&:sum).sort.reverse[0..2].sum
    end
  end
end
