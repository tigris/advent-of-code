# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      symbols = {}
      parts = []

      input.each_with_index do |line, r|
        line.chars.each_with_index do |char, c|
          next if char =~ /[0-9.]/
          symbols[[r,c]] = char
        end
      end

      current = ''
      is_part = false

      input.each_with_index do |line, r|
        "#{line}.".chars.each_with_index do |char, c|
          if char =~ /\d/
            current += char
            is_part = true if symbol_adjacent?(symbols, r, c)
          elsif current != ''
            parts << current.to_i if is_part
            is_part = false
            current = ''
          end
        end
      end

      parts.sum
    end

    def part2(input)
      gears = {}
      ratios = []
      numbers = {}

      input.each_with_index do |line, r|
        line.chars.each_with_index do |char, c|
          gears[[r,c]] = true if char == '*'
        end
      end

      current = ''

      input.each_with_index do |line, r|
        "#{line}.".chars.each_with_index do |char, c|
          if char =~ /\d/
            current += char
          elsif current != ''
            (c - current.length .. c - 1).each{|x| numbers[[r,x]] = current.to_i }
            current = ''
          end
        end
      end

      gears.keys.each do |vector|
        r, c = vector
        gear_numbers = adjacent_numbers(numbers, r, c)
        next unless gear_numbers.size == 2
        ratios << gear_numbers.reduce(&:*)
      end

      ratios.sum
    end

    def adjacent_numbers(numbers, row, col)
      [
        numbers[[row+1,col]],
        numbers[[row+1,col+1]],
        numbers[[row+1,col-1]],

        numbers[[row,col+1]],
        numbers[[row,col-1]],

        numbers[[row-1,col-1]],
        numbers[[row-1,col]],
        numbers[[row-1,col+1]],

      # Potential bug here
      # 124.124
      # ...*...
      # The above would only find 1 number adjacent
      ].compact.uniq
    end

    def symbol_adjacent?(symbols, row, col)
      return true if symbols[[row+1,col]]
      return true if symbols[[row+1,col+1]]
      return true if symbols[[row+1,col-1]]

      return true if symbols[[row,col+1]]
      return true if symbols[[row,col-1]]

      return true if symbols[[row-1,col-1]]
      return true if symbols[[row-1,col]]
      return true if symbols[[row-1,col+1]]

      false
    end
  end
end
