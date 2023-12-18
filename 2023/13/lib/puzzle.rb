# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, allowed_diff=0)
      input.chunk_while{|x| !x.empty? }.map do |image|
        image.pop if image[-1].empty?
        mirrored_left(image, allowed_diff) + (mirrored_above(image, allowed_diff) * 100)
      end.sum
    end

    def mirrored_left(image, allowed_diff)
      rotated = image.map{|r| r.chars}.transpose.map{|c| c.join}
      mirrored_above(rotated, allowed_diff)
    end

    def mirrored_above(image, allowed_diff)
      return 1 if mirrored_diffs(image[0], image[1]) == allowed_diff

      image.each.with_index do |row, i|
        catch(:unmirrored) do
          next if i == 0
          next if !image[i+1]

          diffs = mirrored_diffs(image[i+1], row)
          next if diffs > allowed_diff

          i.times do |count|
            before = image[i-count-1]
            after = image[i+count+2]
            diffs += after ? mirrored_diffs(before, after) : 0
            throw(:unmirrored) if diffs > allowed_diff
          end

          if allowed_diff == diffs
            return i +1
          end
        end
      end

      0
    end

    def mirrored_diffs(left, right)
      right.chars.map.with_index{|c, i| c == left[i] ? c : 'X'}.join.count('X')
    end

    def part2(input)
      part1(input, 1)
    end
  end
end
