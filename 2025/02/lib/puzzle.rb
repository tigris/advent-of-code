# frozen_string_literal: true
# typed: strict

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    extend T::Sig

    sig { params(input: T::Array[String]).returns(Integer) }
    def part1(input)
      ranges = T.must(input[0]).split(',').map{ a, b = it.split('-') ; a.to_i .. b.to_i }

      matches = {}
      ranges.each do |range|
        range.each do
          if matches.key?(it)
            matches[it] += 1 if matches[it].positive?
            next
          end

          string = it.to_s
          next if string.length.odd?

          matches[it] = match?(string, string.length / 2) ? 1 : 0
        end
      end

      matches.map{|k, v| k * v }.sum
    end

    sig { params(input: T::Array[String]).returns(Integer) }
    def part2(input)
      ranges = T.must(input[0]).split(',').map{ a, b = it.split('-') ; a.to_i .. b.to_i }

      matches = {}
      ranges.each do |range|
        range.each do |number|
          if matches.key?(number)
            matches[number] += 1 if matches[number].positive?
            next
          end

          (1 .. (number.to_s.length / 2)).each do |split|
            if match?(number.to_s, split)
              matches[number] = 1
              break
            end
          end

          matches[number] = 0 unless matches.key?(number)
        end
      end

      matches.map{|k, v| k * v }.sum
    end

    sig { params(string: String, split: Integer).returns(T::Boolean) }
    def match?(string, split)
      chars = string.chars
      return false unless chars.length % split == 0

      chunks = chars.each_slice(split)

      first = chunks.next
      return chunks.all? { it == first }
    end
  end
end
