# frozen_string_literal: true

require 'helpers'

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      lines = File.readlines(file).map(&:chomp)
      lines.chunk(&:empty?).map do |_, chunk|
        chunk[0] == '' ? nil : chunk
      end.compact
    end
  end
end
