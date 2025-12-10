# frozen_string_literal: true
# typed: strict

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    extend T::Sig

    sig { params(file: String).returns(T::Array[String]) }
    def call(file)
      File.readlines(file).map(&:chomp)
    end
  end
end
