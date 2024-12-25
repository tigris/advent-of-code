# frozen_string_literal: true

require_relative 'helpers'

# A lock that needs opening
class Lock
  def initialize(rows)
    @rows = init_rows(rows)
  end

  def heights
    @heights ||= (0..@rows[0].length - 1).map { |i| @rows.map { |r| r[i] }.index('.') }
  end

  private

  def init_rows(rows)
    rows[1..]
  end
end

# A key that opens locks
class Key < Lock
  def unlock?(lock)
    lock_heights = lock.heights

    heights.each_with_index do |height, i|
      return false if height + lock_heights[i] > 5
    end

    true
  end

  private

  def init_rows(rows)
    @rows = rows[..-2].reverse
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      objects = input.chunk { !_1.empty? }.select(&:first).map(&:last)
      locks = objects.select { |x| x.first == '#####' }.map { Lock.new _1 }
      keys = objects.select { |x| x.last == '#####' }.map { Key.new _1 }

      keys.map { |k| locks.count { |l| k.unlock?(l) } }.sum
    end

    def part2(_input)
      nil
    end
  end
end
