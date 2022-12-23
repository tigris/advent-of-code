# frozen_string_literal: true

# It's a cube
class Cube
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def adjacent?(cube)
    adjacent_x?(cube) || adjacent_y?(cube) || adjacent_z?(cube)
  end

  def adjacent_x?(cube)
    y == cube.y && z == cube.z && (x - cube.x).abs == 1
  end

  def adjacent_y?(cube)
    x == cube.x && z == cube.z && (y - cube.y).abs == 1
  end

  def adjacent_z?(cube)
    x == cube.x && y == cube.y && (z - cube.z).abs == 1
  end

  def adjacent_x(cubes)
    cubes.select { |_c| adjacent_x?(cube) }
  end

  def adjacent_y(cubes)
    cubes.select { |_c| adjacent_y?(cube) }
  end

  def adjacent_z(cubes)
    cubes.select { |_c| adjacent_z?(cube) }
  end

  def sides_exposed(cubes)
    not_us   = cubes.reject { |c| c.x == x && c.y == y && c.z == z }
    adjacent = not_us.select { |c| adjacent?(c) }
    6 - adjacent.size
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      cubes = input.map { |c| Cube.new(*c) }
      cubes.map { |c| c.sides_exposed(cubes) }.sum
    end

    def part2(input); end
  end
end
