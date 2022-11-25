# frozen_string_literal: true

require 'gamma_rate_calculator'
require 'epsilon_rate_calculator'

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      gamma_rate = GammaRateCalculator.call(input)
      epsilon_rate = EpsilonRateCalculator.call(input)
      gamma_rate * epsilon_rate
    end
  end
end
