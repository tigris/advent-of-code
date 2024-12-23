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

      around += [up(map), down(map)] if vertical
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
          stream.print point.value
        end
        stream.print "\n"

        stream.close if file
      end
    end
  end
end
