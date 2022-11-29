# frozen_string_literal: true

require 'signal_entry'

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      input.map { |s, o| SignalEntry.call(s, o) }.sum
    end
  end
end
