# frozen_string_literal: true

class Hand
  include Comparable

  CARD_VALUES = {
    'j' => 1,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'T' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def hand_value
    modifier = case
      when five_oak? ; 60000000000
      when four_oak? ; 50000000000
      when full_house? ; 40000000000
      when three_oak? ; 30000000000
      when two_pair? ; 20000000000
      when pair? ; 10000000000
      else 0
    end

    value = modifier
    value += CARD_VALUES[cards.chars[0]] * 100000000
    value += CARD_VALUES[cards.chars[1]] * 1000000
    value += CARD_VALUES[cards.chars[2]] * 10000
    value += CARD_VALUES[cards.chars[3]] * 100
    value += CARD_VALUES[cards.chars[4]]
  end

  def <=>(other)
    hand_value <=> other.hand_value
  end

  def num_jays
    cards.scan(/j/).count
  end

  def five_oak?(check_jays=true)
    match = cards.chars.sort.join.match(/([^j])\1\1\1\1/)
    return match if match || !check_jays
    (pair?(false) && num_jays == 3) || (three_oak?(false) && num_jays == 2) || (four_oak?(false) && num_jays == 1) || num_jays >= 4
  end

  def four_oak?(check_jays=true)
    match = cards.chars.sort.join.match(/([^j])\1\1\1/)
    return match if match || !check_jays
    (pair?(false) && num_jays == 2) || (three_oak?(false) && num_jays == 1) || num_jays == 3
  end

  def full_house?(check_jays=true)
    match = cards.chars.sort.join.match(/([^j])\1([^j])\2\2/) || cards.chars.sort.join.match(/([^j])\1\1([^j])\2/)
    return match if match || !check_jays
    (two_pair?(false) && num_jays == 1)
  end

  def three_oak?(check_jays=true)
    match = cards.chars.sort.join.match(/([^j])\1\1/)
    return match if match || !check_jays
    (pair?(false) && num_jays == 1) || num_jays == 2
  end

  def two_pair?(_check_jays=true)
    cards.chars.sort.join.match(/([^j])\1.?([^j])\2/)
  end

  def pair?(check_jays=true)
    match = cards.chars.sort.join.match(/([^j])\1/)
    return match if match || !check_jays
    num_jays == 1
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      hands = {}.tap do |hands|
        input.each do |(hand, bid)|
          hands[Hand.new(hand)] = bid
        end
      end

      hands.keys.sort.each_with_index.map{|h,i| hands[h].to_i * (i+1) }.sum
    end

    def part2(input)
      hands = {}.tap do |hands|
        input.each do |(hand, bid)|
          hands[Hand.new(hand.gsub(/J/, 'j'))] = bid
        end
      end

      hands.keys.sort.each_with_index.map{|h,i| hands[h].to_i * (i+1) }.sum
    end
  end
end
