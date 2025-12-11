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
      up: [-1, 0],
      down_left: [1, -1],
      down_right: [1, 1],
      up_left: [-1, -1],
      up_right: [-1, 1]
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

    # rubocop:disable Naming/PredicateMethod
    def move!(map, direction, new_value = '.')
      return false unless can_move?(map, direction)

      new_point = new_value.is_a?(Point) ? new_value : map[position].class.new(position, new_value)
      map[position] = new_point
      @position = position_for_move(direction)
      map[@position] = self

      true
    end
    # rubocop:enable Naming/PredicateMethod

    def around(map, vertical: true, horizontal: true, diagonal: false)
      around = []

      around += [up(map), down(map)] if vertical
      around += [left(map), right(map)] if horizontal

      if diagonal
        around += [
          up_left(map),
          up_right(map),
          down_left(map),
          down_right(map)
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
          stream.print point ? point.value : ''
        end
        stream.print "\n"

        stream.close if file
      end
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

      new_begin = r1_begin < r2_begin ? r1_begin : r2_begin
      new_end = r1_end > r2_end ? r1_end : r2_end
      (new_begin..new_end)
    end
  end
end
