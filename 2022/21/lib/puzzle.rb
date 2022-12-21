# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      define_methods(input)
      new.root
    end

    def part2(input, increment = 100_000_000_000.to_f)
      input[:root][1] = :==
      input[:humn] = 0.to_f

      define_methods(input)

      new_diff = nil
      old_diff = nil

      loop do
        left = new.send(input[:root][0])
        right = new.send(input[:root][2])
        new_diff = (left - right).abs
        # p "#{input[:humn]} => #{left} == #{right}"
        break if left == right

        if old_diff && new_diff > old_diff
          # We're getting worse, switch it
          increment /= -2.to_f
        end

        input[:humn] += increment

        remove_method(:humn)
        define_methods(input.slice(:humn))
        old_diff = new_diff
      end

      input[:humn]
    end

    def define_methods(input)
      input.each do |k, v|
        if v.is_a?(Array)
          define_method(k) do
            [send(v[0]), send(v[2])].reduce(v[1])
          end
        else
          define_method(k) do
            v
          end
        end
      end
    end
  end
end
