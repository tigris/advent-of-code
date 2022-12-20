# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp).map do |line|
        line =~ /^Blueprint \d+: Each ore robot costs (\d+) ore. Each clay robot costs (\d+) ore. Each obsidian robot costs (\d+) ore and (\d+) clay. Each geode robot costs (\d+) ore and (\d+) obsidian.$/
        {
          ore: { ore: Regexp.last_match[1].to_i },
          clay: { ore: Regexp.last_match[2].to_i },
          obsidian: { ore: Regexp.last_match[3].to_i, clay: Regexp.last_match[4].to_i },
          geode: { ore: Regexp.last_match[5].to_i, obsidian: Regexp.last_match[6].to_i },
          max: {
            ore: [Regexp.last_match[1].to_i, Regexp.last_match[2].to_i, Regexp.last_match[3].to_i, Regexp.last_match[5].to_i].max,
            clay: Regexp.last_match[4].to_i,
            obsidian: Regexp.last_match[6].to_i,
            geode: 10
          }
        }
      end
    end
  end
end
