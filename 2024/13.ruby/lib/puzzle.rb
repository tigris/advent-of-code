# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.sum do |machine|
        tokens_required_to_win(machine)
      end
    end

    def part2(input)
      input = input.map do |x|
        {
          a: x[:a],
          b: x[:b],
          p: [x[:p][0] + 10_000_000_000_000, x[:p][1] + 10_000_000_000_000]
        }
      end

      input.sum do |machine|
        tokens_required_to_win(machine, 10_000_000_000_000)
      end
    end

    private

    def tokens_required_to_win(machine, max = 100)
      # Worked this formula out by hand
      #
      # Example case:
      # 94A + 22B = 8400
      # 34A + 67B = 5400
      #
      # Both of the above forumulas need to be true, there is only 1 single
      # value for A and B that solves that. We then simplify that formula
      #
      # (ax * A) + (bx * B) = px
      # (ay * A) + (by * B) = py
      #
      # Reduce so B is the common solve
      #
      # B = (px - (ax * A)) / bx
      # B = (py - (ay * A)) / by
      #
      # Therefore:
      #
      # (px - (ax * A)) / bx = (py - (ay * A)) / by
      #
      # And now we can solve for A
      #
      # A = ((px * by) - (py * bx)) / ((ax * by) - (ay * bx))
      press_a =
        ((machine[:p][0] * machine[:b][1]) - (machine[:p][1] * machine[:b][0])) /
        ((machine[:a][0] * machine[:b][1]) - (machine[:a][1] * machine[:b][0]))

      press_b = (machine[:p][0] - (machine[:a][0] * press_a)) / machine[:b][0]

      # if max is set, we need to make sure we don't go over it
      return 0 if max && (press_a > max || press_b > max)

      # need to be integers or else it's not a valid solution
      if integer?(press_a) && integer?(press_b)
        ((press_a * 3) + press_b).to_i # A is worth 3 tokens, B is worth 1
      else
        0
      end
    end

    def integer?(value)
      value.to_i == value
    end
  end
end
