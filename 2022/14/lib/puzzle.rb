# frozen_string_literal: true

require 'matrix'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      items = rocks_from_input(input)
      max_down = items.keys.map { |_x, y| y }.max
      flow_sand!(items, max_down, place_on_floor: false)
      # print_cave(items)

      # we don't count the piece of sand at 500,0
      items.select { |_, v| v == :sand }.size - 1
    end

    def part2(input)
      items = rocks_from_input(input)
      max_down = items.keys.map { |_x, y| y }.max + 1
      flow_sand!(items, max_down, place_on_floor: true)
      # print_cave(items)

      items.select { |_, v| v == :sand }.size
    end

    def rocks_from_input(input)
      rocks = {}

      input.each do |row|
        (0..row.length - 2).each do |i|
          rocks[row[i]] = rocks[row[i + 1]] = :rock

          if row[i][0] == row[i + 1][0]
            Range.new(*[row[i][1], row[i + 1][1]].sort).each { |x| rocks[[row[i][0], x]] = :rock }
          else
            Range.new(*[row[i][0], row[i + 1][0]].sort).each { |x| rocks[[x, row[i][1]]] = :rock }
          end
        end
      end

      rocks
    end

    def flow_sand!(items, max, place_on_floor: false)
      loop do
        item = flow(items, max, place_on_floor:)
        # puts "# just placed sand at #{item.inspect}"
        items[item] = :sand
        break if item == [500, 0]

        # print_cave(items) if (items.size % 5_000).zero?
      end

      items
    end

    def print_cave(items)
      min = [items.keys.map { |x, _y| x }.min, items.keys.map { |_x, y| y }.min]
      max = [items.keys.map { |x, _y| x }.max, items.keys.map { |_x, y| y }.max]

      puts '##### cave'
      (0..max[1]).each do |r|
        print format('%03d', r)
        print ' '
        (min[0]..max[0]).each do |c|
          if items[[c, r]] == :rock
            print '#'
          elsif items[[c, r]] == :sand
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

    def flow(items, max, place_on_floor: false)
      pos = [500, 0]

      loop do
        break if items[pos]

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
        unless items[below]
          pos = below
          next
        end

        # first priority, bottom left
        unless items[left_b]
          pos = left_b
          next
        end

        # next priority, bottom right
        unless items[right_b]
          pos = right_b
          next
        end

        return pos
      end

      [500, 0]
    end
  end
end
