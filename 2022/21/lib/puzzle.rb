# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      define_methods(input)
      root
    end

    def part2(input, increment = 100_000_000_000.to_f)
      input[:root][1] = :==
      input[:humn] = increment

      define_methods(input)

      new_diff = nil
      old_diff = nil

      loop do
        left = send(input[:root][0])
        right = send(input[:root][2])
        # p "#{input[:humn]} => #{left} == #{right}"
        break if left == right

        new_diff = (left - right).abs

        if old_diff && new_diff > old_diff
          # We're getting worse, switch it
          increment /= -2.to_f
        end

        input[:humn] += increment

        define_methods(input.slice(:humn))
        old_diff = new_diff
      end

      input[:humn]
    end

    def define_methods(input)
      input.each do |k, v|
        # rubocop:disable Security/Eval,Style/EvalWithLocation,Style/DocumentDynamicEvalDefinition
        eval "undef :#{k}" if respond_to?(k)
        # rubocop:enable Security/Eval,Style/EvalWithLocation,Style/DocumentDynamicEvalDefinition
        if v.is_a?(Array)
          define_singleton_method(k) do
            [send(v[0]), send(v[2])].reduce(v[1])
          end
        else
          define_singleton_method(k) do
            v
          end
        end
      end
    end
  end
end
