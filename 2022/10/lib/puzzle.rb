# frozen_string_literal: true

require 'matrix'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      s = signals(input)
      [20, 60, 100, 140, 180, 220].map { |i| s[i] * i }.sum
    end

    def signals(input)
      signals = [nil]
      last = 1

      input.each_with_index do |cmd, _i|
        if cmd =~ /addx (-?\d+)$/
          signals += [last, last]
          last += ::Regexp.last_match(1).to_i
        else
          signals += [last]
        end
      end

      signals
    end

    def draw_board(input)
      puts ''
      input.each do |r|
        r.each do |c|
          print c
        end
        puts ''
      end
    end

    def part2(input)
      s = signals(input)
      m = Matrix.build(6, 40) { '.' }.to_a

      m.each_with_index do |row, r|
        row.each_with_index do |_, c|
          cycle = (r * row.length) + c + 1
          m[r][c] = '#' if (s[cycle] - c).abs < 2
        end
      end

      m.map(&:join)
    end
  end
end
