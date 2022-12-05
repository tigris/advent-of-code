# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      points = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137, nil => 0 }

      input.map { |line| points[find_illegal(line)[0]] }.sum
    end

    def part2(input)
      points = { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }

      scores = input.map do |line|
        illegal, unclosed = find_illegal(line)
        illegal ? nil : unclosed.reverse.inject(0) { |sum, x| (sum * 5) + points[x] }
      end.compact.sort

      scores[scores.length / 2]
    end

    def find_illegal(line)
      levels  = { '(' => 0, '[' => 0, '{' => 0, '<' => 0 }
      current = []

      line.chars.each do |char|
        # valid level increase
        if levels.key?(char)
          current << char
          levels[char] += 1
          next
        end

        # valid level decrease
        if (char.ord - current.last.ord).abs <= 2
          levels[current.pop] -= 1
          next
        end

        return [char, current]
      end

      [nil, current]
    end
  end
end
