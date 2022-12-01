# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      elves = []
      elf = []
      File.readlines(file).map(&:chomp).each do |line|
        next if line.length.positive? and elf << line.to_i
        elves << elf
        elf = []
      end
      elves << elf
    end
  end
end
