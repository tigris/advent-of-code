# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    MAX = {
      red: 12,
      green: 13,
      blue: 14
    }

    def part1(input)
      input.map{|n, g| valid?(g) ? n.to_i : 0 }.sum
    end

    def part2(input)
      input.map{|n, g| power(g) }.sum
    end

    def valid?(game)
      MAX.keys.all?{|c| valid_color?(game, c) }
    end

    def power(game)
      MAX.keys.map{|c| max_color(game, c) }.reduce(&:*)
    end

    def all_cubes_for_color(game, color)
      game.scan(%r{ (\d+) #{color}}).map(&:first).map(&:to_i)
    end

    def max_color(game, color)
      all_cubes_for_color(game, color).max
    end

    def valid_color?(game, color)
      all_cubes_for_color(game, color).all?{|c| c <= MAX[color] }
    end
  end
end
