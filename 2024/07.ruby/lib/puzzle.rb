# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.map do |line|
        answer, numbers = line.split(': ')
        numbers = numbers.split.map(&:to_i)
        answer = answer.to_i

        valid?(answer, numbers) ? answer : 0
      end.sum
    end

    def part2(input)
      input.map do |line|
        answer, numbers = line.split(': ')
        numbers = numbers.split.map(&:to_i)
        answer = answer.to_i

        valid?(answer, numbers, ['+', '*', 'c']) ? answer : 0
      end.sum
    end

    def valid?(answer, numbers, operators = ['+', '*'])
      search = operators.map do |op|
        numbers[0].send(op, numbers[1])
      end

      numbers[2..].each_with_index do |num, index|
        search = search.map do |s|
          operators.map do |op|
            s.send(op, num)
          end
        end.flatten
      end

      search.include?(answer)
    end
  end
end

class Integer
  def c(right)
    (self.to_s + right.to_s).to_i
  end
end
