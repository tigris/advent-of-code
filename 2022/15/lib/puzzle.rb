# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, row = 2_000_000)
      sensors, beacons = input_to_items(input)
      nothing_at = populate_empty_spots(sensors, beacons, row)
      # print_grid(sensors, beacons, nothing_at)
      nothing_at.keys.select { |x, y| y == row && !beacons[[x, y]] }.size
    end

    def part2(input, max = 4_000_000)
      sensors, = input_to_items(input)
      edge_points = {}
      sensors.each { |pos, d| add_edge_points(pos, d, edge_points) }

      edge_points.each_key do |ep|
        next if (ep[0]).negative? || ep[0] > max
        next if (ep[1]).negative? || ep[1] > max
        next if sensors.any? { |s| sensor_cover?(s, ep) }

        return (4_000_000 * ep[0]) + ep[1]
      end
    end

    def add_edge_points(pos, d, edge_points)
      x, y = pos
      count = 0
      while d >= -1
        edge_points[[x + d + 1, y + count]] = true
        edge_points[[x - d - 1, y + count]] = true
        edge_points[[x + d + 1, y - count]] = true
        edge_points[[x - d - 1, y - count]] = true
        d -= 1
        count += 1
      end
    end

    def sensor_cover?(sensor, pos)
      sensor_pos, distance = sensor
      grid_distance(sensor_pos, pos) <= distance
    end

    def input_to_items(input)
      sensors = {}
      beacons = {}
      input.each do |item|
        sensors[item[:sensor]] = grid_distance(item[:sensor], item[:beacon])
        beacons[item[:beacon]] = true
      end
      [sensors, beacons]
    end

    def populate_empty_spots(sensors, beacons, row)
      nothing_at = {}

      sensors.each do |sensor_position, distance_to_beacon|
        next unless crosses_row(sensor_position, distance_to_beacon, row)

        # If we imagine the route from sensor to beacon, at the point it hits
        # $row we know the distance remaining to the beacon is empty both left
        # and right of the point where it crosses $row.
        crossing_location = [sensor_position[0], row]
        remaining = distance_to_beacon - grid_distance(sensor_position, crossing_location)
        (0..remaining).each do |x|
          [[crossing_location[0] + x, row], [crossing_location[0] - x, row]].each do |position|
            next if beacons[position] || sensors[position]

            nothing_at[position] = true
          end
        end
      end

      nothing_at
    end

    def crosses_row(pos, d, row)
      return true if (pos[1] - d - 1 < row) && (pos[1] + d + 1 > row)

      false
    end

    def grid_distance(a, b)
      (a[0] - b[0]).abs + (a[1] - b[1]).abs
    end

    def print_grid(sensors, beacons, nothing_at)
      items = sensors.keys + beacons.keys + nothing_at.keys
      min = [items.map { |x, _y| x }.min, items.map { |_x, y| y }.min]
      max = [items.map { |x, _y| x }.max, items.map { |_x, y| y }.max]

      puts '##### grid'
      (min[1]..max[1]).each do |y|
        print format('%03d', y)
        print ' '
        (min[0]..max[0]).each do |x|
          if sensors[[x, y]]
            print 'S'
          elsif beacons[[x, y]]
            print 'B'
          elsif nothing_at[[x, y]]
            print '#'
          else
            print '.'
          end
        end
        puts ''
      end
    end
  end
end
