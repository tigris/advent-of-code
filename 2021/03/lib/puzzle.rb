# frozen_string_literal: true

require 'co2_scrubber_rating'
require 'oxygen_generator_rating'

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      co2_scrubber_rating = CO2ScrubberRating.call(input)
      oxygen_generator_rating = OxygenGeneratorRating.call(input)
      co2_scrubber_rating * oxygen_generator_rating
    end
  end
end
