# frozen_string_literal: true

require 'stringio'

# The elf grove
class Grove
  attr_reader :elves

  def initialize(input)
    @elves = {}

    input.each_with_index do |row, r|
      row.chars.each_with_index { |char, c| @elves[[r, c]] = nil if char == '#' }
    end
  end

  def propose_elf_moves(options)
    elves.each do |pos, _move|
      next unless elf_adjacent?(*pos)

      options.each do |direction|
        next unless elf_should_move?(*pos, direction)

        @elves[pos] = new_elf_position(*pos, direction)
        break
      end
    end
  end

  def new_elf_position(r, c, direction)
    case direction
    when :north
      [r - 1, c]
    when :south
      [r + 1, c]
    when :west
      [r, c - 1]
    when :east
      [r, c + 1]
    end
  end

  def elf_should_move?(r, c, direction)
    case direction
    when :north
      !elf_at_any?([[r - 1, c - 1], [r - 1, c], [r - 1, c + 1]])
    when :south
      !elf_at_any?([[r + 1, c - 1], [r + 1, c], [r + 1, c + 1]])
    when :west
      !elf_at_any?([[r, c - 1], [r + 1, c - 1], [r - 1, c - 1]])
    when :east
      !elf_at_any?([[r, c + 1], [r + 1, c + 1], [r - 1, c + 1]])
    end
  end

  def perform_elf_moves!
    proposed_moves = elves.values.group_by { _1 }.transform_values(&:size)

    @elves = elves.to_h do |pos, move|
      [(proposed_moves[move] == 1 && move) || pos, nil]
    end
  end

  def elf_at?(r, c)
    elves.key?([r, c])
  end

  def elf_at_any?(positions)
    positions.any? { |p| elf_at?(*p) }
  end

  def elf_adjacent?(r, c)
    elf_at_any?([
                  [r - 1, c - 1],
                  [r - 1, c],
                  [r - 1, c + 1],
                  [r,   c - 1],
                  [r,   c + 1],
                  [r + 1, c - 1],
                  [r + 1, c],
                  [r + 1, c + 1]
                ])
  end

  def min_height = elves.keys.map(&:first).min
  def max_height = elves.keys.map(&:first).max
  def min_width = elves.keys.map(&:last).min
  def max_width = elves.keys.map(&:last).max

  def draw(stream = $stdout, empty_line_at_end: true)
    (min_height..max_height).each do |r|
      (min_width..max_width).each do |c|
        stream.print elf_at?(r, c) ? '#' : '.'
      end
      stream.puts
    end
    stream.puts if empty_line_at_end
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      moves = %i[north south west east]
      grove = Grove.new(input)

      # puts "== Initial State =="
      # grove.draw

      (1..10).each do |_round|
        grove.propose_elf_moves(moves)
        grove.perform_elf_moves!

        # puts "== End of Round #{round} =="
        # grove.draw
        moves.rotate!
      end

      stream = StringIO.new
      grove.draw(stream, empty_line_at_end: false)
      stream.string.gsub(/[^.]/, '').length
    end

    def part2(input)
      moves = %i[north south west east]
      grove = Grove.new(input)

      count = 0
      loop do
        count += 1
        before = grove.elves
        grove.propose_elf_moves(moves)
        grove.perform_elf_moves!
        break if before == grove.elves

        moves.rotate!
      end

      count
    end
  end
end

__END__
