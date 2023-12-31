# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      input.map { |x| hash_block(x) }.sum
    end

    def part2(input)
      boxes = Array.new(256) { [] }
      input.each { |instruction| update_boxes!(boxes, instruction) }
      calculate_boxes(boxes)
    end

    def hash_block(block)
      block.chars.reduce(0) { |acc, x| hash_char(acc, x) }
    end

    def hash_char(score, item)
      ((score + item.ord) * 17) % 256
    end

    def calculate_boxes(boxes)
      boxes.map.with_index do |box, box_idx|
        box.map.with_index do |lens, lens_idx|
          (1 + box_idx) * (1 + lens_idx) * lens[1]
        end.sum
      end.sum
    end

    def update_boxes!(boxes, instruction)
      label, operation, focal_length = instruction.split(/(-|=)/)
      box = boxes[hash_block(label)]

      if operation == '-'
        box.reject! { |x| x[0] == label }
      elsif operation == '='
        if lens = box.find { |x| x[0] == label }
          lens[1] = focal_length.to_i
        else
          box << [label, focal_length.to_i]
        end
      end
    end
  end
end
