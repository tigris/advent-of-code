# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def folder_sizes(input)
      folder_sizes = {}
      path = []

      input.each do |command|
        next if command =~ (/^dir /) || (command == '$ ls')

        if command =~ /^\$ cd (.+)$/
          if ::Regexp.last_match(1) == '..'
            path.pop
          elsif ::Regexp.last_match(1) != '.'
            full_path = [*path, ::Regexp.last_match(1)].join('/').gsub(%r{/+}, '/')
            path.push(full_path)
          end
          next
        end

        next unless command =~ /^(\d+) .+/

        path.each do |p|
          folder_sizes[p] ||= 0
          folder_sizes[p] += ::Regexp.last_match(1).to_i
        end
      end

      folder_sizes
    end

    def part1(input)
      folder_sizes(input).values.select { |x| x < 100_000 }.sum
    end

    def part2(input)
      sizes = folder_sizes(input).values
      total = 70_000_000
      used = sizes.max
      free = total - used
      needed = 30_000_000

      sizes.select { |x| free + x > needed }.min
    end
  end
end
