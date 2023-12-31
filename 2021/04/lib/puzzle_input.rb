# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      lines = File.readlines(file).map(&:chomp).reject(&:empty?)

      output = [lines.shift.split(',').map(&:to_i)]
      output << card_from_lines(lines.shift(5)) while lines.length.positive?
      output
    end

    def card_from_lines(input)
      input.map { |line| line.strip.split(/\s+/).map(&:to_i) }
    end
  end
end
