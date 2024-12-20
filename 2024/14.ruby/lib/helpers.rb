# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  # Data class to hold point information
  class Point
    attr_reader :position, :value

    def initialize(position, value)
      @position = position
      @value = value
    end

    def left(map)
      map[[position[0], position[1] - 1]]
    end

    def right(map)
      map[[position[0], position[1] + 1]]
    end

    def above(map)
      map[[position[0] - 1, position[1]]]
    end

    def below(map)
      map[[position[0] + 1, position[1]]]
    end

    def around(map, vertical: true, horizontal: true, diagonal: false)
      around = []

      around += [above(map), below(map)] if vertical
      around += [left(map), right(map)] if horizontal

      if diagonal
        around += [
          map[position[0] - 1, position[1] - 1],
          map[position[0] - 1, position[1] + 1],
          map[position[0] + 1, position[1] - 1],
          map[position[0] + 1, position[1] + 1]
        ]
      end

      around.compact
    end
  end

  # Helpers
  class Helpers
    class << self
      def hash_of_points(input)
        hash = {}
        input.each_with_index do |row, r|
          row.chars.each_with_index do |char, c|
            hash[[r, c]] = if block_given?
                             yield(r, c, char)
                           else
                             Point.new([r, c], char)
                           end
          end
        end
        hash
      end

      def traverse_matrix_lrtb(matrix)
        max_row = matrix.keys.map(&:first).max
        max_col = matrix.keys.map(&:last).max

        (0..max_row).each do |r|
          (0..max_col).each do |c|
            yield(matrix[[r, c]], r, c)
          end
        end
      end

      def traverse_matrix_bfs(matrix, starting_point)
        queue = [starting_point]
        visited = []

        while (point = queue.shift)
          next if visited.include?(point)

          visited << point

          queue += point.around(matrix).reject { |p| visited.include?(p) } if yield(point)
        end
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
