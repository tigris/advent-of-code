# frozen_string_literal: true

require 'card'

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      numbers = input.shift
      cards = input.map { |r| Card.new(r) }

      loop do
        number = numbers.shift
        break unless number

        cards.each do |card|
          return card.sum_numbers * number if card.remove_number(number)
        end
      end
    end
  end
end
