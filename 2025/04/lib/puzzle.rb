# frozen_string_literal: true
# typed: strict

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    extend T::Sig

    sig { params(input: T::Array[String]).returns(Integer) }
    def part1(input)
      map = Helpers.hash_of_points(input)
      map.count { movable?(_2, map) }
    end

    sig { params(input: T::Array[String]).returns(Integer) }
    def part2(input)
      map = Helpers.hash_of_points(input)

      removed = 0
      movable = map.select { movable?(_2, map) }

      until movable.empty?
        removing = movable.values.first

        # remove it
        movable.delete(removing.position)
        removing.value = '.'
        removed += 1

        # Now that we moved this one, all the ones around it have 1 less, and now themselves may become movable. So we
        # need to recalculate "movable". But recalculating the entirity of "movable" is non-performant, the only ones
        # that can possibly change are the ones around() the one we just removed.
        for_recalc = removing.around(map, diagonal: true)

        for_recalc.each do |point|
          next if movable.key?(point.position) # already movable
          next unless movable?(point, map) # still not movable

          movable[point.position] = point
        end
      end

      removed
    end

    sig { params(point: Point, map: T::Hash[T::Array[Integer], Point]).returns(T::Boolean) }
    def movable?(point, map)
      return false if point.value == '.' # not even a paper roll

      point.around(map, diagonal: true).count { it.value == '@' } < 4
    end
  end
end
