# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      rules, _, updates = input.chunk(&:empty?).to_a.map { |a| a[1] }
      rules = rules.map { |r| r.split('|').map(&:to_i) }
      updates = updates.map { |u| u.split(',').map(&:to_i) }

      updates.map do |update|
        if valid_update?(update, rules)
          update[update.length / 2]
        else
          0
        end
      end.sum
    end

    def part2(input)
      rules, _, updates = input.chunk(&:empty?).to_a.map { |a| a[1] }
      rules = rules.map { |r| r.split('|').map(&:to_i) }
      updates = updates.map { |u| u.split(',').map(&:to_i) }

      updates.map do |update|
        if valid_update?(update, rules)
          0
        else
          fixed = fix_update(update, rules)
          fixed[fixed.length / 2]
        end
      end.sum
    end

    def valid_update?(numbers, rules)
      numbers.each_with_index do |number, i|
        rules.each do |rule|
          next unless rule[0] == number

          j = numbers.index(rule[1])

          return false if j && i > j
        end
      end

      true
    end

    def fix_update(original, rules)
      indexed = {}.tap do |hash|
        original.each_with_index do |number, i|
          hash[number] = i * 3 # multiply by 3 to give some room for reordering
        end
      end

      rules.each do |rule|
        next unless indexed[rule[0]] && indexed[rule[1]] # skip if this update doesn't have both page numbers
        next if indexed[rule[0]] < indexed[rule[1]] # skip if the page numbers are already in order

        indexed[rule[0]] = indexed[rule[1]] - 1 # move the first page number to the left of the second
        break # to avoid complex math and code, let's just break out of the loop after the first fix
      end

      # put the page numbers in the correct order
      updated = indexed.sort_by { |_k, v| v }.map(&:first)

      # recurse until we've fixed them all - if updated == original then the
      # above rules.each didn't make any changes
      updated = fix_update(updated, rules) unless updated == original

      updated
    end
  end
end
