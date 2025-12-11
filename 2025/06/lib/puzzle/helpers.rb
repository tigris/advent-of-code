# frozen_string_literal: true
# typed: false

require 'puzzle/point'

# Advent of Code puzzle
class Puzzle
  # Helpers
  module Helpers
    class << self
      extend T::Sig

      def hash_of_points(input)
        hash = {}
        input.each_with_index do |row, y|
          row.chars.each_with_index do |char, x|
            hash[[x, y]] = if block_given?
                             yield(x, y, char)
                           else
                             Point.new([x, y], char)
                           end
          end
        end
        hash
      end

      def traverse_matrix_lrtb(matrix)
        max_y = matrix.keys.map(&:first).max
        max_x = matrix.keys.map(&:last).max

        (0..max_y).each do |y|
          (0..max_x).each do |x|
            yield(matrix[[x, y]], x, y)
          end
        end
      end

      def traverse_matrix_bfs(matrix, start_at, end_at, valid_condition = ->(_point) { true })
        queue = [[start_at, []]]
        visited = {}

        while (current = queue.shift)
          position, path = current

          next unless matrix.key?(position)
          next if visited.key?(position)
          next unless valid_condition.call(matrix[position])

          return path + [position] if position == end_at

          visited[position] = true
          matrix[position].around(matrix).each do |point|
            queue << [point.position, path + [position]]
          end
        end

        []
      end

      def print_matrix(input, stream = $stdout)
        file = nil
        if stream.is_a?(String)
          file = File.open(file, 'w')
          stream = file
        end

        traverse_matrix_lrtb(input) do |point, x, y|
          stream.print "\n" if x.zero? && y.positive?
          stream.print point ? point.value : ''
        end
        stream.print "\n"

        stream.close if file
      end

      def string_to_range(string)
        a, b = string.split('-')
        a.to_i..b.to_i
      end

      def range_compact(ranges)
        return ranges if ranges.length <= 1

        sorted_ranges = ranges.sort_by!(&:begin)
        current_begin = sorted_ranges[0].begin
        current_end = sorted_ranges[0].end
        result = []

        i = 1
        len = sorted_ranges.length
        while i < len
          range = sorted_ranges[i]
          range_begin = range.begin
          range_end = range.end

          if range_begin <= current_end + 1
            current_end = range_end if range_end > current_end
          else
            result << (current_begin..current_end)
            current_begin = range_begin
            current_end = range_end
          end
          i += 1
        end

        result << (current_begin..current_end)
        result
      end

      def range_union(range1, range2)
        r1_begin = range1.begin
        r1_end = range1.end
        r2_begin = range2.begin
        r2_end = range2.end

        return if r1_end < r2_begin || r2_end < r1_begin

        new_begin = [r1_begin, r2_begin].min
        new_end = [r1_end, r2_end].max
        (new_begin..new_end)
      end
    end
  end
end
