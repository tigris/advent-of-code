# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    CARD_VALUES = {
      'j' => 1,
      'T' => 10,
      'J' => 11,
      'Q' => 12,
      'K' => 13,
      'A' => 14
    }

    def part1(input)
      input.sort{|a,b| value(a[0]) <=> value(b[0]) }.map.with_index{|x, i| x[1].to_i * (i+1) }.sum
    end

    def part2(input)
      # transform input so we can treat j and J differently but use the same logic
      input = input.map{|x| [x[0].gsub(/J/, 'j'), x[1]] }
      part1(input)
    end

    def value(hand)
      [ type(hand) ] + hand.chars.map{|c| CARD_VALUES[c] || c.to_i }
    end

    def type(hand)
      counts = counts(hand)
      case
      when counts.value?(5) ; 6
      when counts.value?(4) ; 5
      when counts.value?(3) && counts.value?(2) ; 4
      when counts.value?(3) ; 3
      when counts.values.count(2) == 2 ; 2
      when counts.value?(2) ; 1
      else 0
      end
    end

    def counts(hand)
      counts = hand.chars.group_by(&:itself).transform_values(&:size)
      jokers = counts.delete('j')
      return counts unless jokers

      # all 5 jokers, what a trip up
      return {'j' => 5} if jokers == 5

      # finds card with highest count (2 cards the same we find either, doesn't matter which)
      max_key = counts.invert[counts.values.max]
      counts.merge(max_key => counts[max_key] + jokers) # add the jokers
    end
  end
end
