# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    DIGITS = {
      'one' => '1',
      'two' => '2',
      'three' => '3',
      'four' => '4',
      'five' => '5',
      'six' => '6',
      'seven' => '7',
      'eight' => '8',
      'nine' => '9'
    }

    def part1(input)
      input.inject(0) do |sum, line|
        first = line.match(/\d/)[0]
        last = line.reverse.match(/\d/)[0]
        sum += (first + last).to_i
      end
    end

    def part2(input)
      part1 input.map{|l| fix(l) }
    end

    def fix(line)
      # We need to parse twice because something like "oneight" needs to become 18 and gsub only finds "one" on the first pass
      line = line.gsub(/(one|two|three|four|five|six|seven|eight|nine)/) do |char|
        DIGITS[char] + char[-1]
      end

      line.gsub(/(one|two|three|four|five|six|seven|eight|nine)/) do |char|
        DIGITS[char]
      end
    end
  end
end
