# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  # Data class to hold point information
  class Point
    attr_reader :position
    attr_accessor :value

    DIRECTION_DELTAS = {
      down: [1, 0],
      left: [0, -1],
      right: [0, 1],
      up: [-1, 0]
    }.freeze

    def initialize(position, value)
      @position = position
      @value = value
    end

    instance_eval do
      DIRECTION_DELTAS.each_key do |direction|
        define_method(direction) do |map|
          map[position_for_move(direction)]
        end
      end
    end

    def position_for_move(direction)
      delta = DIRECTION_DELTAS[direction]
      return unless delta

      [position[0] + delta[0], position[1] + delta[1]]
    end

    def move!(map, direction, new_value = '.')
      return false unless can_move?(map, direction)

      new_point = new_value.is_a?(Point) ? new_value : map[position].class.new(position, new_value)
      map[position] = new_point
      @position = position_for_move(direction)
      map[@position] = self

      true
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

    private

    def can_move?(map, new_pos)
      map.key?(new_pos)
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

      def print_matrix(input, stream = $stdout)
        file = nil
        if stream.is_a?(String)
          file = File.open(file, 'w')
          stream = file
        end

        if input.is_a?(Hash)
          input.keys.sort.each do |r, c|
            stream.puts '' if c.zero? && !r.zero?
            stream.print input[[r, c]].value
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
