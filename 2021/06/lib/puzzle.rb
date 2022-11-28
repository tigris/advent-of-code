# frozen_string_literal: true

require 'fish'

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input, days = 80)
      all_fish = input.map { |i| Fish.new(i) }

      days.times.each do |_day|
        new_fish = all_fish.map(&:reduce!).compact
        all_fish += new_fish
      end

      all_fish.size
    end
  end
end
