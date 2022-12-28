# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    CACHE = {}
    RATES = {}
    PATHS = {}

    def score(position, time_remaining, opened_valves, with_elephant)
      cache_key = [position, time_remaining, opened_valves, with_elephant]
      return CACHE[cache_key] if CACHE[cache_key]

      if time_remaining.zero?
        return 0 unless with_elephant

        return score(:AA, 26, opened_valves, false)
      end

      max_without_moving = PATHS[position].map { |p| score(p, time_remaining - 1, opened_valves, with_elephant) }.max
      max_with_opening   = 0

      if RATES[position] != 0 && !opened_valves[position]
        max_with_opening = ((time_remaining - 1) * RATES[position]) + score(position, time_remaining - 1, opened_valves.merge(position => true), with_elephant)
      end

      CACHE[cache_key] = [max_without_moving, max_with_opening].max
    end

    def part1(input, max_time = 30, with_elephant = false)
      input.each do |x|
        RATES[x[0]] = x[1]
        PATHS[x[0]] = x[2]
      end

      score(:AA, max_time, {}, with_elephant)
    end

    def part2(input)
      part1(input, 26, true)
    end
  end
end
