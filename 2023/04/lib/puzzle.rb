# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.map do |card|
        (card[0] & card[1]).inject(0){|sum, _| sum = sum == 0 ? 1 : sum * 2 }
      end.sum
    end

    def part2(input)
      totals = Hash.new(0)

      input.each_with_index do |card, idx|
        totals[idx] += 1
        winners = (card[0] & card[1]).size

        # Future cards will get processed this many times in addition to their
        # original process
        (1..winners).each{|i| totals[idx + i] += totals[idx] }
      end

      totals.values.sum

      # Below is the first attempt which worked but is ineffecient
      #
      # cards = {}
      # input.each_with_index{|c, i| cards[i+1] = { index: i+1, winners: (c[0] & c[1]) } }
      #
      # processed = 0
      # to_process = cards.values
      #
      # until to_process.empty? do
      #   processed += 1
      #   card = to_process.shift
      #   (1..card[:winners].size).to_a.reverse.each{|i| to_process.unshift(cards[i + card[:index]]) }
      # end
      #
      # processed
    end
  end
end
