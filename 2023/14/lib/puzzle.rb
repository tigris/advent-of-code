# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      weight(tilt(as_matrix(input), :north, {}))
    end

    def weight(matrix)
      length = matrix.keys.map(&:first).max
      matrix.map { |k, v| v == 'O' ? length + 1 - k[0] : 0 }.sum
    end

    def tilt(matrix, direction, cache)
      key = [matrix.to_s, direction]
      return cache[key] if cache[key]

      length = matrix.keys.map(&:first).max
      width = matrix.keys.map(&:last).max

      tilted = matrix.dup
      shifted = true

      while shifted
        shifted = false

        (0..length).each do |r|
          (0..width).each do |c|
            curr_pos = [r, c]
            next_pos = case direction
                       when :north then [r - 1, c]
                       when :south then [r + 1, c]
                       when :east then [r, c + 1]
                       when :west then [r, c - 1]
                       end

            curr_item = tilted[[r, c]]
            next_item = tilted[next_pos]

            next unless next_pos[0] > -1 && next_pos[1] > -1 && curr_item == 'O' && next_item == '.'

            shifted = true
            tilted[curr_pos] = '.'
            tilted[next_pos] = 'O'
          end
        end
      end

      cache[key] = tilted
    end

    def as_matrix(input)
      result = {}
      input.each_with_index do |row, r|
        row.chars.each_with_index do |char, c|
          result[[r, c]] = char
        end
      end
      result
    end

    def part2(input)
      matrix = as_matrix(input)
      cache = {}

      matrices = {}
      weights = []
      repeated_index = nil

      1_000_000_000.times do |i|
        puts "Cycle: #{i}" if i % 1_000 == 0
        if matrices[matrix]
          repeated_index = i
          break
        end
        matrices[matrix] = i
        weights << weight(matrix)

        matrix = cycle(matrix, cache)
      end

      first_occurence = matrices[matrix]
      last_occurence = repeated_index

      weights[((1_000_000_000 - first_occurence) % (last_occurence - first_occurence)) + first_occurence]
    end

    def cycle(matrix, cache)
      key = [matrix.to_s, :cycle]
      return cache[key] if cache[key]

      matrix = tilt(matrix, :north, cache)
      matrix = tilt(matrix, :west, cache)
      matrix = tilt(matrix, :south, cache)
      matrix = tilt(matrix, :east, cache)

      cache[key] = matrix
    end

    def print_board(matrix)
      length = matrix.keys.map(&:first).max
      width = matrix.keys.map(&:last).max

      (0..length).each do |r|
        puts
        (0..width).each do |c|
          char = matrix[[r, c]]
          char = length + 1 - r if char == 'O'
          char = 'X' if char == 10
          print char
        end
      end
    end
  end
end
