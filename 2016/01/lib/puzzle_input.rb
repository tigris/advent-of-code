# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map{|l| l.strip.split(/, /) }
    end
  end
end
