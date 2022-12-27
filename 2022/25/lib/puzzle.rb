# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  # Snafu converter
  class Snafu
    def self.to_decimal(snafu)
      snafu.chars.reverse.each_with_index.map do |e, i|
        e.sub(/-/, '-1').sub(/=/, '-2').to_i * (i.zero? ? 1 : 5**i)
      end.sum
    end
  end

  # Decimal converter
  class Decimal
    def self.to_snafu(decimal)
      string = decimal.to_s(5)
      while string =~ /3|4/
        string.sub!(/(?<leader>.?)(?<digit>3|4)/) do
          leader = Regexp.last_match[:leader]
          digit = Regexp.last_match[:digit] == '3' ? '=' : '-'

          leader = case leader
                   when '='
                     '-'
                   when '-'
                     0
                   when ''
                     1
                   else
                     leader.to_i + 1
                   end

          "#{leader}#{digit}"
        end
      end
      string
    end
  end

  class << self
    def part1(input)
      Decimal.to_snafu(
        input.map { |i| Snafu.to_decimal(i) }.sum
      )
    end

    def part2(_input)
      nil
    end
  end
end
