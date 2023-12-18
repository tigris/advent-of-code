# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.map do |row|
        arrangements(
          row.sub(/ .+$/, '').chars + ['.'],
          row.scan(/\d+/).map(&:to_i)
        )
      end.sum
    end

    def arrangements(springs, counts, current_group=[], cache={})
      cache_key = [springs, counts, current_group]
      # p cache_key
      return cache[cache_key] if cache[cache_key]

      if springs.empty?
        return 1 if counts.empty?
        return 0
      end

      count = case springs.first
        when '?'
          # puts "Got a ? - recursing"
          # recurse with both options replacing the question mark
          arrangements(['.'] + springs[1..], counts, current_group, cache) + arrangements(['#'] + springs[1..], counts, current_group, cache)
        when '#'
          if current_group.length == counts.first
            # puts "Got a # that would be too big"
            # this hash makes this whole record invalid cos it will be too big
            0
          else
            # puts "Got a # - continuing"
            # continue to next the next hash
            arrangements(springs[1..], counts, current_group + ['#'], cache)
          end
        when '.'
          if current_group.empty?
            # puts "Got a . - continuing"
            # continue untouched
            arrangements(springs[1..], counts, current_group, cache)
          elsif current_group.length == counts.first
            # puts "Got a . - terminating current group"
            # terminating '.' so start a new group
            arrangements(springs[1..], counts[1..], [], cache)
          else
            # puts "Got a . - terminated early"
            # we terminated before reaching the expected size of this group
            0
          end
        else
          raise RuntimeError
      end

      # puts "#{cache_key} => #{count}"
      cache[cache_key] = count
    end

    def part2(input)
      input.map do |row|
        springs = row.sub(/ .+$/, '')
        counts = row.scan(/\d+/).map(&:to_i)

        arrangements(("#{springs}?" * 5).sub(/\?$/, '.').chars, counts * 5)
      end.sum
    end
  end
end
