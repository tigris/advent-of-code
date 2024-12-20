# frozen_string_literal: true

require_relative 'helpers'

MAP_SIZE = [11, 7].freeze
# MAP_SIZE = [101, 103]

# it's a robot
class Robot
  attr_reader :position, :velocity

  def initialize(position, velocity)
    @position = position
    @velocity = velocity
  end

  def move
    @position = [@position[0] + @velocity[0], @position[1] + @velocity[1]]
    @position[0] %= MAP_SIZE[0]
    @position[1] %= MAP_SIZE[1]
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      robots = input.map do |line|
        position = line.match(/p=(.+),(.+) /).captures.map(&:to_i)
        velocity = line.match(/v=(.+),(.+)$/).captures.map(&:to_i)
        Robot.new(position, velocity)
      end

      100.times { robots.each(&:move) }

      robot_count(robots).reduce(:*)
    end

    def part2(input)
      robots = input.map do |line|
        position = line.match(/p=(.+),(.+) /).captures.map(&:to_i)
        velocity = line.match(/v=(.+),(.+)$/).captures.map(&:to_i)
        Robot.new(position, velocity)
      end

      (0..20_000).each do |i|
        # puts "Moves: #{i}"
        if tree?(robots)
          # puts "Found tree at quadrant #{quadrant}"
          # print_map(robots, false)
          return i
        end

        robots.each(&:move)
      end

      nil
    end

    private

    def tree?(robots)
      counts = robot_count(robots)
      counts.any? { |c| c > 240 } ? counts : false
    end

    def robot_count(robots)
      top_left = [(0..(MAP_SIZE[0] / 2) - 1), (0..(MAP_SIZE[1] / 2) - 1)]
      top_right = [((MAP_SIZE[0] / 2) + 1..MAP_SIZE[0] - 1), (0..(MAP_SIZE[1] / 2) - 1)]
      bottom_left = [(0..(MAP_SIZE[0] / 2) - 1), ((MAP_SIZE[1] / 2) + 1..MAP_SIZE[1] - 1)]
      bottom_right = [((MAP_SIZE[0] / 2) + 1..MAP_SIZE[0] - 1), ((MAP_SIZE[1] / 2) + 1..MAP_SIZE[1] - 1)]

      [
        robots.count { |r| top_left[0].include?(r.position[0]) && top_left[1].include?(r.position[1]) },
        robots.count { |r| top_right[0].include?(r.position[0]) && top_right[1].include?(r.position[1]) },
        robots.count { |r| bottom_left[0].include?(r.position[0]) && bottom_left[1].include?(r.position[1]) },
        robots.count { |r| bottom_right[0].include?(r.position[0]) && bottom_right[1].include?(r.position[1]) }
      ]
    end

    def print_map(robots, blank_middle)
      (0..MAP_SIZE[1] - 1).each do |y|
        (0..MAP_SIZE[0] - 1).each do |x|
          if blank_middle && (x == MAP_SIZE[0] / 2 || y == MAP_SIZE[1] / 2)
            print(' ')
            next
          end

          count = robots.count { |robot| robot.position == [x, y] }
          count.zero? ? print('.') : print(count)
        end
        puts
      end
    end
  end
end
