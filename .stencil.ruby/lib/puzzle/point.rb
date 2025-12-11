# frozen_string_literal: true
# typed: false

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
end
