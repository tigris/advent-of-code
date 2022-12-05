# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input[:moves].each do |move|
        from = move[1] - 1
        to   = move[2] - 1

        (0..move[0] - 1).each do
          item = input[:stacks][from].shift
          input[:stacks][to].unshift(item)
        end
      end

      input[:stacks].map(&:first).join
    end

    def part2(input)
      input[:moves].each do |move|
        from = move[1] - 1
        to   = move[2] - 1

        items = input[:stacks][from].shift(move[0])
        input[:stacks][to].unshift(*items)
      end

      input[:stacks].map { |x| x[0] || ' ' }.join
    end
  end
end
