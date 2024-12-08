# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    class LoopError < StandardError; end

    def part1(input)
      map = input.is_a?(Hash) ? input : Helpers.hash_of_points(input)

      guard = map.select{ |_k, v| ['^','v','<','>'].include?(v) }.keys.first
      moves = { [guard, map[guard]] => true }

      while guard = move!(map, guard)
        raise LoopError if moves.key?([guard, map[guard]])

        moves[[guard, map[guard]]] = true
      end

      moves.keys.map(&:first).uniq.size
    end

    def part2(input)
      map = Helpers.hash_of_points(input)
      locations = []

      map.keys.each do |pos|
        next unless map[pos] == '.'

        map[pos] = '#'

        begin
          x = part1(map)
        rescue LoopError
          locations << pos
        end

        map = Helpers.hash_of_points(input)
      end

      locations.size
    end

    def move!(map, guard)
      new_guard = case map[guard]
                  when '^'
                    [guard[0] - 1, guard[1]]
                  when 'v'
                    [guard[0] + 1, guard[1]]
                  when '<'
                    [guard[0], guard[1] - 1]
                  when '>'
                    [guard[0], guard[1] + 1]
                  else
                    raise StandardError, "Invalid guard"
                  end

      if map[new_guard] == '#'
        new_guard = guard
        map[guard] = { '^' => '>', '>' => 'v', 'v' => '<', '<' => '^' }[map[guard]]
      elsif !map.key?(new_guard)
        return nil
      else
        map[new_guard] = map[guard]
        map[guard] = '.'
      end
      new_guard
    end
  end
end
