# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      input[1..].each_with_index.map{ |x, i| [x, input[i]] }.select{|x| x[0] > x[1] }.size
    end
  end
end
