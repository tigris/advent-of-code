# frozen_string_literal: true
# typed: strict

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    extend T::Sig

    sig { params(input: T::Array[String]).returns(Integer) }
    def part1(input)
      banks = input.map { it.chars.map(&:to_i) }
      banks.map { joltage(it, 2) }.sum
    end

    sig { params(input: T::Array[String]).returns(Integer) }
    def part2(input)
      banks = input.map { it.chars.map(&:to_i) }
      banks.map { joltage(it, 12) }.sum
    end

    sig { params(bank: T::Array[Integer], size: Integer).returns(Integer) }
    def joltage(bank, size)
      return 0 if size.zero?

      start_of_bank = T.must(bank[0..-size])
      max_location = T.must(start_of_bank.index(start_of_bank.max))

      rest = joltage(T.must(bank[(max_location + 1)..]), size - 1)

      multiplier = size == 1 ? 1 : (10**(size - 1))

      max_value = T.must(start_of_bank[max_location])
      Integer((max_value * multiplier) + rest)
    end
  end
end
