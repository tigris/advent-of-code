# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      rows, moves = File.read(file).split("\n\n")
      rows = rows.split("\n")[0..-2]

      stacks = []
      stack_size = (rows[-1].length + 1) / 4

      (0..stack_size - 1).each do |column|
        rows.each do |row|
          item = row.chars.slice(column * 4, 4) || next
          item = item.join.gsub(/(\[|\]| )/, '')
          stacks[column] ||= []
          stacks[column] << item if item =~ /[A-Z]/
        end
      end

      {
        stacks:,
        moves: moves.split("\n").map { |l| l.sub(/move (\d+) from (\d+) to (\d+)/, '\1 \2 \3').split.map(&:to_i) }
      }
    end
  end
end
