# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  # Helpers
  class Helpers
    class << self
      def hash_of_points(input)
        hash = {}
        input.each_with_index do |row, r|
          row.chars.each_with_index do |char, c|
            hash[[r, c]] = if block_given?
                             yield(char)
                           else
                             char
                           end
          end
        end
        hash
      end

      def around(point, diagonals: false, map: nil)
        around = [
          [point[0] - 1, point[1]],
          [point[0], point[1] - 1],
          [point[0], point[1] + 1],
          [point[0] + 1, point[1]]
        ]

        around += [
          [point[0] - 1, point[1] - 1],
          [point[0] - 1, point[1] + 1],
          [point[0] + 1, point[1] - 1],
          [point[0] + 1, point[1] + 1]
        ] if diagonals

        map.nil? ? around : around.select { |p| map.key?(p) }
      end

      def print_matrix(input, file: false)
        stream = file ? File.open(file, 'w') : $stdout
        if input.is_a?(Hash)
          input.keys.sort.each do |r, c|
            stream.puts '' if c.zero? && !r.zero?
            stream.print input[[r, c]]
          end
          stream.puts
        elsif input.is_a?(Array)
          input.each do |row|
            line = row.is_a?(Array) ? row.join : row
            stream.puts line
          end
        end
        stream.close if file
      end
    end
  end
end
