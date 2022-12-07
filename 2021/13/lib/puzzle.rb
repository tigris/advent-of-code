# frozen_string_literal: true

require 'matrix'

# Advent of Code puzzle
class Puzzle
  class << self
    def matrix(input, num_folds)
      dots, folds = input

      rows = dots.map(&:last).max + 1
      cols = dots.map(&:first).max + 1
      puts "ROWS: #{rows}"
      puts "COLS: #{cols}"

      puts '======== BUILDING MATRIX ============'
      m = Matrix.build(rows, cols) { |r, c| dots.include?([c, r]) ? 1 : 0 }.to_a

      folds.slice(0, num_folds).each do |direction, location|
        puts '======== FOLDING ============'
        if direction == :y
          (1..location).each do |x|
            folded = m.delete_at(location + 1)
            m[location - x].each_with_index { |_, i| m[location - x][i] = 1 if folded[i] == 1 }
          end
          m.delete_at(location)
        else
          m.each do |r|
            r.each_with_index do |v, c|
              next if c < location

              r[location + location - c] = 1 if v == 1 && c != location
              r[c] = nil
            end
            r.compact!
          end
        end
      end

      m
    end

    def part1(input)
      matrix(input, 1).map(&:sum).sum
    end

    def part2(input)
      string = ''
      matrix(input, 100).each do |r|
        r.each { |v| string += v == 1 ? '#' : '.' }
        string += "\n"
      end
      string
    end
  end
end
