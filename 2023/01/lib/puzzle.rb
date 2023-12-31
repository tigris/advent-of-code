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
      part1(input.map { |l| fix(l) })
    end

    def fix(line)
      # We parse once from the front and once from the back since we only care about the first and last digits
      line = line.sub(/(one|two|three|four|five|six|seven|eight|nine)/) do |char|
        DIGITS[char] + char[-1] # We add back on the last character since it may be the first character of another digit
      end

      line = line.reverse.sub(/(eno|owt|eerht|ruof|evif|xis|neves|thgie|enin)/) do |char|
        DIGITS[char.reverse]
      end

      line.reverse
    end
  end
end
