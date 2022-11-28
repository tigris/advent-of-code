# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input, days = 256)
      age_counts = Hash.new(0).tap { |x| input.each { |i| x[i] += 1 } }

      days.times do
        x = Hash.new(0).tap do |i|
          age_counts.each do |k, v|
            if k.zero?
              i[6] += v
              i[8] += v
            else
              i[k - 1] += v
            end
          end
        end
        age_counts = x
      end

      age_counts.values.sum
    end
  end
end
