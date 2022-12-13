# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      (0..(input.length - 1) / 2).map do |i|
        left  = input[i * 2]
        right = input[(i * 2) + 1]

        sort(left, right) < 1 ? i + 1 : 0
      end.sum
    end

    def part2(input)
      decoder1 = [[2]]
      decoder2 = [[6]]

      sorted = (input + [decoder1] + [decoder2]).sort { |a, b| sort(a, b) }

      (sorted.index(decoder1) + 1) * (sorted.index(decoder2) + 1)
    end

    def sort(left, right)
      # puts "### comparing #{left.inspect} <=> #{right.inspect}"
      left = [left] unless left.is_a?(Array)
      right = [right] unless right.is_a?(Array)

      left.each_with_index do |l, i|
        r = right[i]
        # puts "#{l.inspect} <=> #{r.inspect}"

        return 1 if r.nil? # right side ran out of items

        val = if l.is_a?(Array) || r.is_a?(Array)
                sort(l, r)
              else
                l <=> r
              end

        return val unless val.zero?
      end

      left.size <=> right.size
    end
  end
end
