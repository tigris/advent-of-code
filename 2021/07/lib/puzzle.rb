# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      min = input.min
      max = input.max

      position = nil
      least_fuel = max * max * max
      (min..max).each do |pos|
        fuel_used = input.map do |i|
          a = (i - pos).abs
          ((a * a) + a) / 2
        end.sum
        if fuel_used < least_fuel
          position = pos
          least_fuel = fuel_used
        end
      end

      least_fuel
    end
  end
end
