# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      head_positions = [[0, 0]]
      tail_positions = [[0, 0]]

      input.each do |direction, length|
        length = length.to_i

        (1..length).each do |_i|
          head_positions << move(head_positions.last, direction)
          tail_positions << tail_position_for(head_positions, tail_positions.last)
        end
      end

      tail_positions.uniq.size
    end

    def part2(input)
      head_positions = [[0, 0]]
      tail_positions = {
        1 => [[0, 0]],
        2 => [[0, 0]],
        3 => [[0, 0]],
        4 => [[0, 0]],
        5 => [[0, 0]],
        6 => [[0, 0]],
        7 => [[0, 0]],
        8 => [[0, 0]],
        9 => [[0, 0]]
      }

      input.each do |direction, length|
        length = length.to_i

        (1..length).each do |_i|
          head_positions << move(head_positions.last, direction)

          tail_positions.each do |k, _v|
            following = k == 1 ? head_positions : tail_positions[k - 1]
            tail_positions[k] << tail_position_for(following, tail_positions[k].last)
          end
        end
      end

      tail_positions[9].uniq.size
    end

    def draw_board(head_positions, tail_positions)
      (-10..10).each do |row|
        (-20..20).each do |col|
          char = row.zero? && col.zero? ? 's' : '.'
          if head_positions[0] == row && head_positions[1] == col
            char = 'H'
          else
            tail_positions.keys.sort.reverse.each do |k|
              v = tail_positions[k].last
              char = k if (v[0] == row) && (v[1] == col)
            end
          end
          print char
        end
        print "\n"
      end
    end

    def tail_position_for(head_positions, tail_position)
      head_position = [head_positions.last[0], head_positions.last[1]]

      return head_position if head_position == tail_position
      return [tail_position[0], tail_position[1]] if (head_position[0] - tail_position[0]).abs <= 1 && (head_position[1] - tail_position[1]).abs <= 1

      row = tail_position[0]
      if head_position[0] > tail_position[0]
        row += 1
      elsif head_position[0] < tail_position[0]
        row -= 1
      end

      col = tail_position[1]
      if head_position[1] > tail_position[1]
        col += 1
      elsif head_position[1] < tail_position[1]
        col -= 1
      end

      [row, col]
    end

    def move(position, direction)
      case direction
      when 'R'
        [position[0], position[1] + 1]
      when 'L'
        [position[0], position[1] - 1]
      when 'D'
        [position[0] + 1, position[1]]
      else
        [position[0] - 1, position[1]]
      end
    end
  end
end
