# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      map = Helpers.hash_of_points(input)

      answers = []

      map.values.select { |v| v != '.' && map.values.count(v) > 1 }.uniq.each do |freq|
        answers += antinodes(map, freq)
      end

      answers.uniq.count
    end

    def part2(input)
      map = Helpers.hash_of_points(input)

      answers = []

      map.values.select { |v| v != '.' && map.values.count(v) > 1 }.uniq.each do |freq|
        answers += antinodes(map, freq, -1)
      end

      answers += map.reject { |_k, v| v == '.' }.map(&:first)

      answers.uniq.count
    end

    def antinodes(map, freq, max = 1)
      nodes = map.select { |_k, v| v == freq }.map(&:first)
      antinodes = []

      nodes.each_with_index do |pos, i|
        nodes.each_with_index do |pos2, j|
          next if i == j

          distance_r = pos2[0] - pos[0]
          distance_c = pos2[1] - pos[1]

          antinode = [pos[0] + (distance_r * -1), pos[1] + (distance_c * -1)]
          while map.key?(antinode)
            # puts "freq: #{pos.inspect}=#{freq}, match=#{pos2.inspect} antinode: #{antinode.inspect}"
            antinodes << antinode
            break if max == 1

            antinode = [antinode[0] + (distance_r * -1), antinode[1] + (distance_c * -1)]
          end
        end
      end

      antinodes
    end
  end
end
