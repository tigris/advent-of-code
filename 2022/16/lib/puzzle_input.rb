# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp).map do |line|
        line =~ /^Valve (?<valve>\w\w) has flow rate=(?<rate>\d+); tunnels? leads? to valves? (?<paths>[\w, ]+)$/
        [
          Regexp.last_match[:valve].to_sym,
          Regexp.last_match[:rate].to_i,
          Regexp.last_match[:paths].split(', ').map(&:to_sym)
        ]
      end
    end
  end
end
