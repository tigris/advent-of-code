# frozen_string_literal: true

CACHE = {}.freeze
# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.each_with_index.map do |blueprint, i|
        CACHE.clear
        print "Blueprint #{i + 1}: "
        max = max_geodes(blueprint, 24, 0, 0, 0, 0, 1, 0, 0, 0)
        puts max
        max * (i + 1)
      end.sum
    end

    def max_geodes(blueprint, minutes_left, ore, clay, obsidian, geodes, ore_bots, clay_bots, obsidian_bots, geode_bots)
      return geodes if minutes_left.zero?
      return geodes + geode_bots if minutes_left == 1 # can't create any more bots anyway

      key = [
        minutes_left,
        ore % (blueprint[:max][:ore] + 1),
        clay % (blueprint[:max][:clay] + 1),
        obsidian % (blueprint[:max][:obsidian] + 1),
        geodes,
        ore_bots, clay_bots, obsidian_bots, geode_bots
      ]
      return CACHE[key] if CACHE[key]

      # The initial assumption is we can't make any more geodes than what we have now
      max = geodes

      # Let's see what happens if we build no bots?
      other = max_geodes(blueprint, minutes_left - 1, ore + ore_bots, clay + clay_bots, obsidian + obsidian_bots, geodes + geode_bots, ore_bots, clay_bots, obsidian_bots,
                         geode_bots)
      max = other if other > max

      # What if we build an ore bot?
      if ore >= blueprint[:ore][:ore] && ore_bots < blueprint[:max][:ore]
        other = max_geodes(blueprint, minutes_left - 1, ore - blueprint[:ore][:ore] + ore_bots, clay + clay_bots, obsidian + obsidian_bots, geodes + geode_bots, ore_bots + 1,
                           clay_bots, obsidian_bots, geode_bots)
        max = other if other > max
      end

      # What if we build a clay bot?
      if ore >= blueprint[:clay][:ore] && clay_bots < blueprint[:max][:clay]
        other = max_geodes(blueprint, minutes_left - 1, ore - blueprint[:clay][:ore] + ore_bots, clay + clay_bots, obsidian + obsidian_bots, geodes + geode_bots, ore_bots,
                           clay_bots + 1, obsidian_bots, geode_bots)
        max = other if other > max
      end

      # What if we build an obsidian bot?
      if ore >= blueprint[:obsidian][:ore] && clay >= blueprint[:obsidian][:clay] && obsidian_bots < blueprint[:max][:obsidian]
        other = max_geodes(blueprint, minutes_left - 1, ore - blueprint[:obsidian][:ore] + ore_bots, clay - blueprint[:obsidian][:clay] + clay_bots, obsidian + obsidian_bots,
                           geodes + geode_bots, ore_bots, clay_bots, obsidian_bots + 1, geode_bots)
        max = other if other > max
      end

      # What if we build a geode bot?
      if ore >= blueprint[:geode][:ore] && obsidian >= blueprint[:geode][:obsidian]
        other = max_geodes(blueprint, minutes_left - 1, ore - blueprint[:geode][:ore] + ore_bots, clay + clay_bots, obsidian - blueprint[:geode][:obsidian] + obsidian_bots,
                           geodes + geode_bots, ore_bots, clay_bots, obsidian_bots, geode_bots + 1)
        max = other if other > max
      end

      CACHE[key] = max
    end

    def part2(input)
      input.take(3).each_with_index.map do |blueprint, i|
        CACHE.clear
        print "Blueprint #{i + 1}: "
        max = max_geodes(blueprint, 32, 0, 0, 0, 0, 1, 0, 0, 0)
        puts max
        max
      end.reduce(:*)
    end
  end
end
