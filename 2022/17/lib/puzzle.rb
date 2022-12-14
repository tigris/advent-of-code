# frozen_string_literal: true

require 'stringio'

# Dwayne Johnstone
class Rock
  attr_reader :positions, :shape

  def initialize(shape, start_row, log_moves = false)
    @shape = shape
    @log = log_moves

    # Positions are left_most, bottom_most, right_most, top_most, *others
    # This is to make collision checks against a wall or floor faster
    case shape
    when :plus
      @positions = [[start_row + 1, 2], [start_row, 3], [start_row + 1, 4], [start_row + 2, 3], [start_row + 1, 3]]
    when :h_line
      @positions = [[start_row, 2], [start_row, 3], [start_row, 5], [start_row, 4]]
    when :v_line
      @positions = [[start_row + 1, 2], [start_row, 2], [start_row + 2, 2], [start_row + 3, 2]]
    when :back_l
      @positions = [[start_row, 2], [start_row, 3], [start_row, 4], [start_row + 2, 4], [start_row + 1, 4]]
    when :cube
      @positions = [[start_row, 2], [start_row, 3], [start_row + 1, 3], [start_row + 1, 2]]
    end
  end

  def log(msg)
    return unless @log

    p msg
  end

  def fall!(other)
    log "#{shape} => fall!"
    return if (positions[1][0]).zero?

    new_pos = positions.map { |x, y| [x - 1, y] }
    return if new_pos.intersect?(other)

    @positions = new_pos
  end

  def >(other)
    log "#{shape} => right!"
    return if positions[2][1] == 6

    new_pos = positions.map { |x, y| [x, y + 1] }
    return if new_pos.intersect?(other)

    @positions = new_pos
  end

  def <(other)
    log "#{shape} => left!"
    return if (positions[0][1]).zero?

    new_pos = positions.map { |x, y| [x, y - 1] }
    return if new_pos.intersect?(other)

    @positions = new_pos
  end

  def at?(x, y)
    @positions.include?([x, y])
  end
end

class Cave
  attr_reader :rock_count, :taken_positions

  def initialize
    @rock_count = 0
    @falling_rock = nil
    @taken_positions = []
  end

  def add_rock(rock)
    @falling_rock = rock
  end

  def settle_rock!
    @rock_count += 1
    @taken_positions += @falling_rock.positions
    @falling_rock = nil
  end

  def draw(top = nil, bottom = 0, stream = $stdout)
    top ||= height(true)
    stream.puts

    top.downto(bottom).each do |x|
      stream.print '|'
      7.times do |y|
        if @taken_positions.include?([x, y])
          stream.print '#'
        elsif @falling_rock&.positions&.include?([x, y])
          stream.print '@'
        else
          stream.print '.'
        end
      end
      stream.puts '|'
    end

    stream.puts "+-------+\n"
  end

  def height(include_falling = false)
    return -1 if taken_positions.empty?

    positions = taken_positions
    positions += @falling_rock.positions if @falling_rock && include_falling

    positions.map(&:first).max
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, amount = 2022)
      cave = Cave.new
      rock_order = %i[h_line plus back_l v_line cube].cycle
      jet_order = input.cycle

      # amount = 15
      first_rock = nil
      while amount.positive?
        amount -= 1
        rock = Rock.new(rock_order.next, cave.height + 4)
        cave.add_rock(rock)
        loop do
          rock.send(jet_order.next.to_sym, cave.taken_positions)
          break unless rock.fall!(cave.taken_positions)
        end

        cave.settle_rock!
      end

      # cave.draw
      cave.height + 1
    end

    def part2(input)
      # part1(input, 1_000_000_000_000)
    end
  end
end
