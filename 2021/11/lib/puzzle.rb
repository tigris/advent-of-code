# frozen_string_literal: true

require 'matrix'

# The plural is octopi
class Octopus
  attr_reader :row, :column, :value

  def initialize(r, c, v)
    @row = r
    @column = c
    @value = v
    @flashed = @processed = false
  end

  def step!
    @value += 1
    @flashed = value > 9
  end

  def flash!
    @value += 1
    @flashed = value > 9
  end

  def flashed?
    @flashed
  end

  def processed?
    @processed
  end

  def process!
    @processed = true
  end

  def reset!
    @processed = @flashed = false
    return false if value <= 9

    @value = 0
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, count = 100)
      flash_count = 0

      m = Matrix[*input]
      m.each_with_index { |v, r, c| input[r][c] = Octopus.new(r, c, v) }

      count.times do
        m.each(&:step!)

        processed = 1
        while processed.positive?
          processed = 0
          m.each_with_index do |v, r, c|
            next unless v.flashed?
            next if v.processed?

            v.process!
            processed += 1
            around(input, r, c).each { |r1, c1| input[r1][c1].flash! }
          end
        end

        flash_count += m.select(&:reset!).size
      end

      flash_count
    end

    def part2(input)
      count = 0
      size = input.map(&:size).sum

      loop do
        count += 1
        copy = input.clone.map { |x| x.map(&:clone) }
        part1(copy, count)

        break if copy.flatten.map(&:value).select(&:zero?).size == size
      end

      count
    end

    def around(input, r, c)
      [
        [r + 1, c - 1],
        [r + 1, c],
        [r + 1, c + 1],
        [r, c - 1],
        [r, c + 1],
        [r - 1, c - 1],
        [r - 1, c],
        [r - 1, c + 1]
      ].reject { |r1, c1| input[r1]&.at(c1).nil? || r1.negative? || c1.negative? }
    end
  end
end
