# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      elves = []
      elf = []
      File.readlines(file).map(&:chomp).each do |line|
        if line.length.positive?
          elf << line.to_i
        else
          elves << elf
          elf = []
        end
      end
      elves << elf
      elves
    end
  end
end
