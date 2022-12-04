# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      priorities = {}.tap do |p|
        (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index do |l, i|
          p[l] = i + 1
        end
      end

      sacks = []

      input.each do |sack|
        mid = sack.length / 2
        sacks << [sack[0..mid - 1], sack[mid..sack.length]]
      end

      sacks.map do |sack|
        sack[0].chars.uniq.intersection(sack[1].chars.uniq).map { |x| priorities[x] }.sum
      end.sum
    end

    def part2(input)
      priorities = {}.tap do |p|
        (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index do |l, i|
          p[l] = i + 1
        end
      end

      badges = []
      while input.length.positive?
        sacks = input.slice!(0, 3)
        badge = sacks[0].chars.intersection(sacks[1].chars, sacks[2].chars)
        badges << badge
      end

      badges.flatten.map { |x| priorities[x] }.sum
    end
  end
end
