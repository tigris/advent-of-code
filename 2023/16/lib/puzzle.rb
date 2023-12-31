# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, start = [0, 0, :right])
      matrix = {}

      input.each_with_index do |row, r|
        row.chars.each_with_index do |char, c|
          matrix[[r, c]] = [char, []]
        end
      end

      search = [start]
      until search.empty?
        r, c, d = search.shift
        pos = [r, c]

        item = matrix[pos]
        next unless item
        next if item[1].include?(d)

        item[1] << d

        case [item[0], d]
        when ['.', :right], ['-', :right], ['/', :up], ['\\', :down]
          search << [r, c + 1, :right]
        when ['.', :left], ['-', :left], ['/', :down], ['\\', :up]
          search << [r, c - 1, :left]
        when ['.', :up], ['|', :up], ['/', :right], ['\\', :left]
          search << [r - 1, c, :up]
        when ['.', :down], ['|', :down], ['/', :left], ['\\', :right]
          search << [r + 1, c, :down]
        when ['-', :up], ['-', :down]
          search << [r, c - 1, :left]
          search << [r, c + 1, :right]
        when ['|', :left], ['|', :right]
          search << [r - 1, c, :up]
          search << [r + 1, c, :down]
        end
      end

      matrix.values.map(&:last).reject(&:empty?).size
    end

    def part2(input)
      rows = input.map.with_index do |row, r|
        [part1(input, [r, 0, :right]), part1(input, [r, row.length - 1, :left])]
      end

      cols = input[0].chars.map.with_index do |_, c|
        [part1(input, [0, c, :down]), part1(input, [input.length - 1, c, :up])]
      end

      (rows + cols).flatten.max
    end
  end
end
