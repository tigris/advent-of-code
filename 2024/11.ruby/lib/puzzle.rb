# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, blinks = 25)
      counts = Hash.new(0)
      answers = {}

      input[0].split.each { |x| counts[x.to_i] = 1 }

      blinks.times do
        new_counts = Hash.new(0)

        counts.each do |stone, count|
          next if count.zero?

          result = answers[stone] ||= answer(stone)
          counts[stone] -= count

          result.each { |r| new_counts[r] += count }
        end

        counts.merge!(new_counts) { |_, old_count, new_count| old_count + new_count }
      end

      counts.values.sum
    end

    def part2(input)
      part1(input, 75)
    end

    def answer(number)
      return [1] if number.zero?
      return split(number) if number.to_s.length.even?

      [number * 2024]
    end

    def split(number)
      mid = number.to_s.length / 2
      div = 10**mid
      [number / div, number % div]
    end
  end
end
