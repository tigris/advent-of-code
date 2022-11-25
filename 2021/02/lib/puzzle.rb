# frozen_string_literal: true

require 'submarine'

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      sub = Submarine.new
      input.each { |command, amount| sub.public_send(command.to_sym, amount.to_i) }
      sub.depth * sub.horizontal
    end
  end
end
