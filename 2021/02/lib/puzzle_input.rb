# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map { |x| [x.split[0], x.split[1].to_i] }
    end
  end
end
