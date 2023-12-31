# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      {}.tap do |games|
        File.readlines(file).map(&:chomp).map do |line|
          number, game = line.split(':', 2)
          games[number.sub(/^Game /, '')] = game
        end
      end
    end
  end
end
