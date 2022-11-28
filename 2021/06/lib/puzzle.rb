# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input, days = 80)
      days.times do
        input.map! { |x| x.zero? ? [6, 8] : x - 1 }
        input.flatten!
      end
      input.size
    end
  end
end
