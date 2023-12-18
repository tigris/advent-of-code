# frozen_string_literal: true

require 'pairing_heap'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      matrix = {}
      input.each_with_index do |row, r|
        row.chars.each_with_index do |char, c|
          matrix[[r,c]] = char.to_i
        end
      end

      search = PairingHeap::MinPriorityQueue.new

      finish = [input.length-1,input[0].length-1]
      search.push([[[0,1]], :right, 1, 0], 0)
      search.push([[[1,0]], :down, 1, 0], 0)

      seen = {}

      while search.any?
        path, direction, moves, loss = search.pop
        position = path[0]

        current_loss = matrix[position]
        next unless current_loss # not on map
        new_loss = loss + current_loss

        if position == finish
          # p path
          return new_loss
        end

        key = [position,direction,moves]
        next if seen[key] && seen[key] <= new_loss # been here for less
        seen[key] = new_loss

        if direction == :up
          left_position = [position[0],position[1]-1]
          right_position = [position[0],position[1]+1]
          left_direction = :left
          right_direction = :right
          straight_position = [position[0]-1,position[1]]
        elsif direction == :down
          left_position = [position[0],position[1]+1]
          right_position = [position[0],position[1]-1]
          left_direction = :right
          right_direction = :left
          straight_position = [position[0]+1,position[1]]
        elsif direction == :right
          left_position = [position[0]-1,position[1]]
          right_position = [position[0]+1,position[1]]
          left_direction = :up
          right_direction = :down
          straight_position = [position[0],position[1]+1]
        elsif direction == :left
          left_position = [position[0]+1,position[1]]
          right_position = [position[0]-1,position[1]]
          left_direction = :down
          right_direction = :up
          straight_position = [position[0],position[1]-1]
        end

        begin
          search.push([[left_position] + path, left_direction, 1, new_loss], new_loss)
        rescue ArgumentError
          nil
        end
        begin
          search.push([[right_position] + path, right_direction, 1, new_loss], new_loss)
        rescue ArgumentError
          nil
        end
        begin
          search.push([[straight_position] + path, direction, moves+1, new_loss], new_loss) if moves < 3
        rescue ArgumentError
          nil
        end
      end

      0
    end

    def part2(input)
      matrix = {}
      input.each_with_index do |row, r|
        row.chars.each_with_index do |char, c|
          matrix[[r,c]] = char.to_i
        end
      end

      search = PairingHeap::MinPriorityQueue.new

      finish = [input.length-1,input[0].length-1]
      search.push([[[0,1]], :right, 1, 0], 0)
      search.push([[[1,0]], :down, 1, 0], 0)

      seen = {}

      while search.any?
        path, direction, moves, loss = search.pop
        position = path[0]

        current_loss = matrix[position]
        next unless current_loss # not on map
        new_loss = loss + current_loss

        if position == finish
          if moves > 3
            # p path
            return new_loss
          else
            next
          end
        end

        key = [position,direction,moves]
        next if seen[key] && seen[key] <= new_loss # been here for less
        seen[key] = new_loss

        if direction == :up
          left_position = [position[0],position[1]-1]
          right_position = [position[0],position[1]+1]
          left_direction = :left
          right_direction = :right
          straight_position = [position[0]-1,position[1]]
        elsif direction == :down
          left_position = [position[0],position[1]+1]
          right_position = [position[0],position[1]-1]
          left_direction = :right
          right_direction = :left
          straight_position = [position[0]+1,position[1]]
        elsif direction == :right
          left_position = [position[0]-1,position[1]]
          right_position = [position[0]+1,position[1]]
          left_direction = :up
          right_direction = :down
          straight_position = [position[0],position[1]+1]
        elsif direction == :left
          left_position = [position[0]+1,position[1]]
          right_position = [position[0]-1,position[1]]
          left_direction = :down
          right_direction = :up
          straight_position = [position[0],position[1]-1]
        end

        begin
          search.push([[left_position] + path, left_direction, 1, new_loss], new_loss) if moves > 3
        rescue ArgumentError
          nil
        end
        begin
          search.push([[right_position] + path, right_direction, 1, new_loss], new_loss) if moves > 3
        rescue ArgumentError
          nil
        end
        begin
          search.push([[straight_position] + path, direction, moves+1, new_loss], new_loss) if moves < 10
        rescue ArgumentError
          nil
        end
      end

      0
    end
  end
end
