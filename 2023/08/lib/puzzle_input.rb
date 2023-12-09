# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      lines = File.readlines(file).map(&:chomp)

      data = { 'moves' => lines.shift.chars }
      lines.shift

      lines.each do |line|
        line = line.gsub(/[() ]/, '')
        position, neighbours = line.split(/=/)
        data[position] = neighbours.split(/,/)
      end

      data
    end
  end
end
