# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp)
      # .map(&:to_i)
      # .map{|x| x.split(',') }
    end
  end
end
