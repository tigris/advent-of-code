# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      wires = wires_from_input(input)
      wires = evaluate_wires(wires)
      wires_to_binary(wires, 'z').to_i(2)
    end

    def part2(input)
      # wires = wires_from_input(input)
      # pairs = wires.reject { |_, v| v.is_a?(Integer) }.keys.sort
      #
      # num_swaps = 2
      # op = '&'
      # if pairs.include?('k20') # prod input
      #   num_swaps = 4
      #   op = '+'
      # end
      #
      # tried = {}
      # winning = {}
      # while true
      #   break if tried.size > pairs.size ** num_swaps
      #   swaps = swaps(pairs, num_swaps, tried)
      #   winning[swaps] = true if correct?(swap(wires, swaps), op)
      #   break if winning[swaps] && num_swaps == 2
      # end
      #
      # puts tried.inspect
      # puts winning.inspect
      #
      # winning.size > 0 ? winning.keys.sort.first.flatten.sort.join(',') : nil
    end

    private

    def swaps(pairs, num_swaps, tried)
      swaps = []

      while swaps.size < num_swaps
        l << pairs.shift
        r << pairs.shift
      end

      tried[swaps] = true
      swaps
    end

    def swap(wires, swaps)
      new_wires = wires.dup

      swaps.each do |l, r|
        new_wires[r] = wires[l]
        new_wires[l] = wires[r]
      end

      new_wires
    end

    def wires_to_binary(wires, key)
      wires.keys.sort.select { |k| k[0] == key }.map { |k| wires[k] }.reverse.join
    end

    def correct?(wires, op)
      wires = evaluate_wires(wires)

      x = wires_to_binary(wires, 'x')
      y = wires_to_binary(wires, 'y')
      z = wires_to_binary(wires, 'z')

      # Eval is safe, untainted values
      eval("#{x.to_i(2)} #{op} #{y.to_i(2)}") == z.to_i(2)
    end

    def wires_from_input(input)
      wires = {}

      input.each do |line|
        next if line.empty?

        wires[::Regexp.last_match(1)] = ::Regexp.last_match(2).to_i if line =~ /^(...): (\d)$/

        next unless line =~ /^(...) (AND|XOR|OR) (...) -> (...)$/

        op = {
          'AND' => '&',
          'XOR' => '^',
          'OR' => '|'
        }[::Regexp.last_match(2)]

        wires[::Regexp.last_match(4)] = [::Regexp.last_match(1), op, ::Regexp.last_match(3)]
      end

      wires
    end

    def evaluate_wires(wires)
      wires = wires.dup

      loop do
        wires.each do |k, v|
          wires[k] = evaluate_wire(wires, v) if v.is_a?(Array)
        end

        break if wires.values.all? { |v| v.is_a?(Integer) }
      end

      wires
    end

    def evaluate_wire(wires, val)
      return val if wires[val].is_a?(Integer)
      return val unless wires[val[0]].is_a?(Integer) && wires[val[2]].is_a?(Integer)

      left = wires[val[0]]
      right = wires[val[2]]

      # Eval is safe, untainted values
      eval "#{left} #{val[1]} #{right}"
    end
  end
end
