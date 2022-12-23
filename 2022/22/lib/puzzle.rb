# frozen_string_literal: true

# To the treasure!
class Map
  attr_reader :direction, :position, :grid

  def initialize(map_as_string)
    @grid = map_as_string.map(&:chars)
    @direction = :right
    @position = [0, grid[0].index('.')]
  end

  def report
    [
      "row: #{row}",
      "col: #{column}",
      "dir: #{direction}"
    ].join("\n")
  end

  def row
    position[0] + 1
  end

  def column
    position[1] + 1
  end

  def move_vertical(amount, way)
    amount.times do
      char = nil
      new_pos = position[0]
      while !char || char == ' '
        new_pos = new_pos.send(way, 1)

        # Deal with wrapping at start/end of column
        if new_pos.negative?
          new_pos = grid.length - 1
        elsif new_pos > grid.length - 1
          new_pos = 0
        end

        char = grid[new_pos][position[1]]
      end

      break if char == '#' # can't move

      @position = [new_pos, position[1]]
    end
  end

  def move_horizontal(amount, way)
    amount.times do
      new_pos = position[1].send(way, 1)

      # Deal with wrapping at start/end of line
      if new_pos.negative?
        new_pos = grid[position[0]].length - 1 # There are no spaces on end of line to worry about
      elsif new_pos > grid[position[0]].length - 1
        new_pos = grid[position[0]].index { |x| x != ' ' } # Can't use [0] cos might be ' '
      end

      char = grid[position[0]][new_pos]

      # If we hit a space, that's the same as hitting start of the line, wrap it
      if char == ' '
        new_pos = grid[position[0]].length - 1
        char = grid[position[0]][new_pos]
      end

      break if char == '#' # can't move

      @position = [position[0], new_pos]
    end
  end

  def move!(move)
    if move.is_a?(Integer)
      op = %i[up left].include?(direction) ? :- : :+
      %i[up down].include?(direction) ? move_vertical(move, op) : move_horizontal(move, op)
    else
      rotate!(move)
    end
  end

  def rotate!(way)
    @direction = {
      %i[left up] => :left,
      %i[left down] => :right,
      %i[left left] => :down,
      %i[left right] => :up,
      %i[right up] => :right,
      %i[right down] => :left,
      %i[right left] => :up,
      %i[right right] => :down
    }[ [way, direction] ]
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      map = Map.new(input[:map])

      input[:moves].each do |move|
        # puts "#=> #{move}"
        map.move!(move)
        # puts map.report
      end

      facing = { right: 0, down: 1, left: 2, up: 3 }[map.direction]

      (1000 * map.row) + (4 * map.column) + facing
    end

    def part2(input)
      map = Map.new(input[:map])

      facing = { right: 0, down: 1, left: 2, up: 3 }[map.direction]

      (1000 * map.row) + (4 * map.column) + facing
    end
  end
end
