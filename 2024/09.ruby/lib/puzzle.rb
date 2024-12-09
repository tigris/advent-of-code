# frozen_string_literal: true

require_relative 'helpers'

# a file or free block in the drive
class Block
  attr_accessor :file_index, :start, :length

  def initialize(file_index, start, length)
    @file_index = file_index
    @start = start
    @length = length
  end

  def end_index
    return start if length.zero?

    start + length - 1
  end

  def free?
    file_index == :free
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input = input[0].chars.map(&:to_i)
      drive = []

      index = 0
      input.each_slice(2) do |file, free|
        drive += [index] * file
        drive += ['.'] * free if free
        index += 1
      end

      sorted = drive.dup

      while sorted.include?('.')
        last = sorted.pop
        next if last == '.'

        sorted[sorted.index('.')] = last
      end

      sorted.each_with_index.map { |n, i| n * i }.sum
    end

    def part2(input)
      input = input[0].chars.map(&:to_i)
      drive = []

      file_index = 0
      drive_index = 0

      input.each_slice(2) do |file, free|
        if file.positive?
          drive << Block.new(file_index, drive_index, file)
          drive_index += file
        end

        if free&.positive?
          drive << Block.new(:free, drive_index, free)
          drive_index += free
        end

        file_index += 1
      end

      sorted = drive.dup

      drive.sort_by(&:end_index).reverse.each do |block|
        next if block.free?

        spot = sorted.find { |n| n.free? && n.length >= block.length }
        next unless spot
        next if spot.start > block.start

        # new block we will put in place
        new_block = Block.new(block.file_index, spot.start, block.length)

        # old block is now free
        block.file_index = :free

        # if the new block is smaller than the free block, we need to split it
        if spot.length > block.length
          spot.start += block.length
          spot.length -= block.length
        else
          sorted.delete(spot)
        end

        sorted << new_block
      end

      sorted.reject(&:free?).map do |block|
        (block.start..block.end_index).map do |i|
          block.file_index * i
        end.sum
      end.sum
    end
  end
end
