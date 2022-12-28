# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def draw(elf, blizzards, max_row, max_column)
      directions = { right: '>', down: 'v', left: '<', up: '^' }
      (0..max_row).each do |row|
        (0..max_column).each do |column|
          pos = [row, column]

          if elf == pos
            print 'E'
            next
          end

          if blizzards[pos]
            if blizzards[pos].size == 1
              print directions[blizzards[pos][0]]
              next
            elsif blizzards[pos].size > 1
              print blizzards[pos].size
              next
            end
          end

          if (row.zero? && column != 1) || column.zero? || column == max_column || (row == max_row && column != max_column - 1)
            print '#'
          else
            print '.'
          end
        end
        puts
      end
    end

    def blizzards_from_input(input)
      blizzards = {}
      directions = { '>' => :right, 'v' => :down, '<' => :left, '^' => :up }

      input.each_with_index do |row, r|
        row.chars.each_with_index do |char, c|
          next unless directions[char]

          blizzards[[r, c]] = [directions[char]]
        end
      end

      blizzards
    end

    def blow!(blizzards, max_row, max_column)
      new_blizzards = {}
      blizzards.each do |pos, directions|
        directions.each do |f|
          new = pos.dup
          # move it
          operation = %i[up left].include?(f) ? :- : :+
          if %i[up down].include?(f)
            new[0] = new[0].send(operation, 1)
          else
            new[1] = new[1].send(operation, 1)
          end

          # wrap it
          if (new[0]).zero?
            new[0] = max_row - 1
          elsif new[0] == max_row
            new[0] = 1
          elsif (new[1]).zero?
            new[1] = max_column - 1
          elsif new[1] == max_column
            new[1] = 1
          end

          if new_blizzards[new]
            new_blizzards[new] << f
          else
            new_blizzards[new] = [f]
          end
        end
      end
      new_blizzards
    end

    def possible_moves(elf, blizzards, max_row, max_column)
      moves = []
      [
        [elf[0] + 1, elf[1]],
        [elf[0], elf[1] + 1],
        [elf[0] - 1, elf[1]],
        [elf[0], elf[1] - 1],
        [elf[0], elf[1]]
      ].each do |pos|
        next if (pos[0]).negative? || pos[1] < 1 || pos[1] >= max_column
        next if pos[0] < 1 && pos[1] != 1 # Allowed on first row if it's the start
        next if pos[0] >= max_row && pos[1] != max_column - 1 # Allowed on last row if it's the exit
        next if blizzards[pos]

        moves << pos
      end
      moves
    end

    def part1(input, start = [0, 1], finish = nil, starting_moves = 0)
      max_row    = input.length - 1
      max_column = input[0].length - 1
      max_combos = (max_row - 1) * (max_column - 1) / 2

      finish ||= [max_row, max_column - 1]
      search = [[start, starting_moves]]
      best   = 1_000_000 # something huge

      blizzards = [blizzards_from_input(input)]
      max_combos.times { |i| blizzards << blow!(blizzards[i], max_row, max_column) }
      searched = {}

      until search.empty?
        elf, steps = search.shift
        next if steps >= best - 1 # Already found a path as good as this

        next if searched[[elf, steps]]

        searched[[elf, steps]] = true

        # We got there!
        if elf == finish
          best = steps if steps < best
          next
        end

        # p "===== #{elf} - #{steps}"
        # draw(elf, blizzards[steps % max_combos], max_row, max_column)
        # puts

        possible_moves(elf, blizzards[(steps % max_combos) + 1], max_row, max_column).each { |move| search << [move, steps + 1] }
      end

      best - starting_moves
    end

    def part2(input)
      max_row    = input.length - 1
      max_column = input[0].length - 1

      start  = [0, 1]
      finish = [max_row, max_column - 1]

      first = part1(input, start, finish, 0)
      second = part1(input, finish, start, first)
      third = part1(input, start, finish, first + second)

      [first, second, third].sum
    end
  end
end
