# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      t, r = input.split("\n").map{|l| l.scan(/\d+/).map(&:to_i) }
      (0...t.length).map{|i| (1...t[i]).map{|h| (h * (t[i] - h)) > r[i] ? 1 : 0}.sum}.reduce(:*)
    end

    def part2(input)
      t, r = input.split("\n").map{|l| l.scan(/\d/).join.to_i }
      (1...t).map{|h| (h * (t - h)) > r ? 1 : 0}.sum
    end
  end
end
