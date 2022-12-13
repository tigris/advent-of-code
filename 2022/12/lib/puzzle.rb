# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def walk(input, start, finish)
      visited = {}
      searching = [{ steps: 0, coords: start }]
      until searching.empty?
        current = searching.shift
        if visited.key?(current[:coords])
          visited[current[:coords]] = [current[:steps], visited[current[:coords]]].min
          next
        end

        visited[current[:coords]] = current[:steps]

        around(input, current[:coords][0], current[:coords][1]).each do |r, c|
          current_height = input[current[:coords][0]][current[:coords][1]]
          next_height    = input[r][c]
          searching << { steps: current[:steps] + 1, coords: [r, c] } if next_height <= (current_height.ord + 1).chr
        end
      end

      visited[finish]
    end

    def part1(input)
      start = nil
      finish = nil

      input.each_with_index do |row, r|
        row.each_with_index do |char, c|
          case char
          when 'S'
            start = [r, c]
            input[r][c] = 'a'
          when 'E'
            finish = [r, c]
            input[r][c] = 'z'
          end
        end
      end

      walk(input, start, finish)
    end

    def around(input, r, c)
      [[r + 1, c], [r - 1, c], [r, c + 1], [r, c - 1]].select { |r1, c1| !r1.negative? && !c1.negative? && input.at(r1)&.at(c1) }
    end

    def part2(input)
      start_options = []
      finish = nil

      input.each_with_index do |row, r|
        row.each_with_index do |char, c|
          case char
          when 'S', 'a'
            input[r][c] = 'a'
            start_options << [r, c]
          when 'E'
            finish = [r, c]
            input[r][c] = 'z'
          end
        end
      end

      start_options.map { |r, c| walk(input, [r, c], finish) }.compact.min
    end
  end
end
