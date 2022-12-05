# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      direction = 0
      vertical = 0
      horizontal = 0

      input.each do |move|
        x = move.chars
        direction += x.shift == 'L' ? 270 : 90
        direction -= 360 if direction >= 360

        length = x.join.to_i
        length *= -1 if direction > 90

        vertical += length if direction == 0 || direction == 180
        horizontal += length if direction == 90 || direction == 270
      end

      vertical.abs + horizontal.abs
    end

    def part2(input)
      direction = 0
      vertical = 0
      horizontal = 0

      positions = []
      catch(:dupe) do
        input.each do |move|
          x = move.chars
          direction += x.shift == 'L' ? 270 : 90
          direction -= 360 if direction >= 360

          length = x.join.to_i
          length *= -1 if direction > 90

          if direction == 0 || direction == 180
            range = length.negative? ? (vertical + length .. vertical).to_a.reverse : (vertical .. vertical + length).to_a
            range.shift
            range.each do |l|
              positions << [ l, horizontal ]
              throw(:dupe) if positions.size != positions.uniq.size
            end
          else
            range = length.negative? ? (horizontal + length .. horizontal).to_a.reverse : (horizontal .. horizontal + length).to_a
            range.shift
            range.each do |l|
              positions << [ vertical, l ]
              throw(:dupe) if positions.size != positions.uniq.size
            end
          end

          vertical, horizontal = positions.last
        end
      end

      positions.last.map(&:abs).sum
    end
  end
end
