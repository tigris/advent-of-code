# frozen_string_literal: true

require 'matrix'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      rocks = rocks_from_input(input)
      max_down = rocks.map { |_x, y| y }.max
      sand = flow_sand(rocks, max_down, place_on_floor: false)
      # print_cave(rocks, sand)

      sand.size - 1 # we don't count the piece of sand at 500,0
    end

    def part2(input)
      rocks = rocks_from_input(input)
      max_down = rocks.map { |_x, y| y }.max + 1
      sand = flow_sand(rocks, max_down, place_on_floor: true)
      # print_cave(rocks, sand)

      sand.size
    end

    def rocks_from_input(input)
      covered = []

      input.each do |row|
        (0..row.length - 2).each do |i|
          covered << row[i]
          covered << row[i + 1]
          if row[i][0] == row[i + 1][0]
            Range.new(*[row[i][1], row[i + 1][1]].sort).each { |x| covered << [row[i][0], x] }
          else
            Range.new(*[row[i][0], row[i + 1][0]].sort).each { |x| covered << [x, row[i][1]] }
          end
        end
      end

      covered.uniq.sort
    end

    def flow_sand(rocks, max, place_on_floor: false)
      sand = []
      loop do
        sand << flow(rocks, sand, max, place_on_floor:)
        # puts "# just placed sand at #{sand.last.inspect}"
        break if sand.last == [500, 0]

        print_cave(rocks, sand) if (sand.size % 5_000).zero?
      end

      sand
    end

    def print_cave(rocks, sand)
      covered = rocks + sand
      min = [covered.map { |x, _y| x }.min, covered.map { |_x, y| y }.min]
      max = [covered.map { |x, _y| x }.max, covered.map { |_x, y| y }.max]

      puts '##### cave'
      (0..max[1]).each do |r|
        print format('%03d', r)
        print ' '
        (min[0]..max[0]).each do |c|
          if rocks.include?([c, r])
            print '#'
          elsif sand.include?([c, r])
            print 'o'
          elsif (r == 500) && c.zero?
            print '+'
          else
            print '.'
          end
        end
        puts ''
      end
    end

    def flow(rocks, sand, max, place_on_floor: false)
      covered = rocks + sand

      # rules
      #
      # - start at 500,0
      # - if found nothing below (500,1), keep moving
      # - if found a rock below, stop and return coords
      # - if found sand below:
      #   - if blocked both left (499,0) and right (501,0), stop and return coords
      #   - diagonal left unless blocked left
      #   - diagonal right unless blocked right
      pos = [500, 0]

      loop do
        break if sand.include?(pos)

        # We're on the floor
        if pos[1] == max
          break unless place_on_floor

          return pos
        end

        # puts "checking #{pos.inspect}"
        below   = [pos[0], pos[1] + 1]
        left_b  = [pos[0] - 1, below[1]]
        right_b = [pos[0] + 1, below[1]]

        # nothing below, easy one
        unless covered.include?(below)
          pos = below
          next
        end

        # first priority, bottom left
        unless covered.include?(left_b)
          pos = left_b
          next
        end

        # next priority, bottom right
        unless covered.include?(right_b)
          pos = right_b
          next
        end

        return pos
      end

      [500, 0]
    end
  end
end
