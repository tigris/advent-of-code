# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      data = input.dup
      seeds = data.shift[0].split(/ /)[1..].map(&:to_i)
      minimum = 1_000_000_000_000_000

      map_types = data.map do |map_type|
        [map_type[0]] + map_type[1..].map do |map|
          dest, source, range = map.split(/ /, 3).map(&:to_i)
          [(source...(source + range)), dest - source]
        end.sort { |a, b| a[0].begin <=> b[0].begin }
      end

      seeds.each do |seed|
        # puts "seed => #{seed}"
        location = seed

        map_types.each do |map_type|
          # puts "  #{map_type[0]}"
          catch(:mapped) do
            map_type[1..].each do |map|
              next unless map[0].cover?(location)

              # puts "    #{map[0]}/#{map[1]}"
              location += map[1]
              throw(:mapped)
            end
          end
          # puts "    #{seed} => #{location}"
        end

        minimum = location if location < minimum
      end

      minimum
    end

    def part2(input)
      data = input.dup

      seed_data = data.shift[0].split(/ /)[1..].map(&:to_i)
      seed_ranges = []

      seed_data.each_slice(2) do |seed_start, seed_range|
        seed_ranges << (seed_start...(seed_start + seed_range))
      end

      map_types = data.map do |map_type|
        [map_type[0]] + map_type[1..].map do |map|
          dest, source, range = map.split(/ /, 3).map(&:to_i)
          [(source...(source + range)), dest - source]
        end.sort { |a, b| a[0].begin <=> b[0].begin }
      end

      total_seeds = seed_ranges.map(&:size).sum
      processed = 0

      minimum = 1_000_000_000_000_000
      seed_ranges.sort_by(&:begin).each do |range|
        range.each do |seed|
          processed += 1
          puts "processed: #{processed} (#{(processed.to_f / total_seeds * 100).to_i}%)" if processed % 1_000_000 == 0
          # puts "seed => #{seed}"
          location = seed

          map_types.each do |map_type|
            # puts "  #{map_type[0]}"
            catch(:mapped) do
              map_type[1..].each do |map|
                if location < map[0].begin
                  throw(:mapped) # keep the same
                elsif location < map[0].end
                  # puts "    #{map[0]}/#{map[1]}"
                  location += map[1]
                  throw(:mapped)
                end
              end
            end
            # puts "    #{seed} => #{location}"
          end

          minimum = location if location < minimum
        end
      end

      minimum
    end
  end
end
