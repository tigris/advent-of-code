# frozen_string_literal: true

# Advent of Code puzzle
class GammaRateCalculator
  class << self
    def call(input)
      binary = (0..input[0].length - 1).map { |i| input.map { |x| x[i].to_i }.sum > (input.length / 2) ? '1' : '0' }
      binary.join.to_i(2)
    end
  end
end
