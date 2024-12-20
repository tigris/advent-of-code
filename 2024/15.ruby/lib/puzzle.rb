# frozen_string_literal: true

require_relative 'helpers'

# My custom point movement class
class Point < Puzzle::Point
  def move!(matrix, direction, new_value = '.')
    return false if robot? && !move_blocks!(matrix, direction)

    super
  end

  def robot?
    value == '@'
  end

  def block?
    ['O', '[', ']'].include?(value)
  end

  def can_move?(matrix, direction)
    new_position = position_for_move(direction)
    matrix[new_position].value != '#'
  end

  def collect_blocks(matrix, direction)
    collect_from_pos = %i[up down].include?(direction) ? 1 : 0
    comparison_pos = %i[up down].include?(direction) ? 0 : 1
    sort_delta = %i[down right].include?(direction) ? 1 : -1
    comparison = %i[down right].include?(direction) ? :> : :<

    blocks = matrix
             .select { |pos, _| pos[collect_from_pos] == position[collect_from_pos] && pos[comparison_pos].send(comparison, position[comparison_pos]) }
             .sort_by { |pos, _| pos[comparison_pos] * sort_delta } # Sort based on movement direction
             .take_while { |_, point| point.block? }
             .map { |_, point| point }

    return blocks if blocks.empty? || blocks.last.value == 'O' # part 1 style block
    return blocks if %i[left right].include?(direction) # only need to complicate things for up/down movement sitting on half a block

    # If we're moving up or down, we need to recursively collect the other half of the block
    blocks = blocks.map do |block|
      other = block.value == '[' ? matrix[block.position_for_move(:right)] : matrix[block.position_for_move(:left)]
      [block, other, other.collect_blocks(matrix, direction)]
    end

    blocks.flatten.uniq.sort_by { |block| block.position[comparison_pos] * sort_delta } # Sort based on movement direction
  end

  private

  def can_move_blocks?(matrix, blocks, direction)
    return blocks.last.can_move?(matrix, direction) if blocks.last.value == 'O' # part 1 style block

    blocks.all? { |b| b.can_move?(matrix, direction) }
  end

  def move_blocks!(matrix, direction)
    blocks = collect_blocks(matrix, direction)
    return true if blocks.empty?
    return false unless can_move_blocks?(matrix, blocks, direction)

    blocks.reverse.each do |block|
      raise StandardError unless block.move!(matrix, direction)
    end

    true
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      matrix = Helpers.hash_of_points(input[0]) { |r, c, char| ::Point.new([r, c], char) }
      commands = input[1].join.chars.map { |x| { 'v' => :down, '^' => :up, '<' => :left, '>' => :right }[x] }

      robot = matrix.find { |_, p| p.robot? }.last

      commands.each do |command|
        robot.move!(matrix, command)
      end

      matrix.values.select { |p| p.value == 'O' }.map { |p| (p.position[0] * 100) + p.position[1] }.sum
    end

    def part2(input)
      matrix = Helpers.hash_of_points(widen(input[0])) { |r, c, char| ::Point.new([r, c], char) }
      commands = input[1].join.chars.map { |x| { 'v' => :down, '^' => :up, '<' => :left, '>' => :right }[x] }

      robot = matrix.find { |_, p| p.robot? }.last

      commands.each do |command|
        robot.move!(matrix, command)
      end

      matrix.values.select { |p| p.value == '[' }.map { |p| (p.position[0] * 100) + p.position[1] }.sum
    end

    private

    def widen(lines)
      lines.map do |line|
        line = line.gsub('.', '..')
        line = line.gsub(/@/, '@.')
        line = line.gsub('#', '##')
        line = line.gsub('O', '[]')
        line
      end
    end
  end
end
