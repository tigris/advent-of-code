# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      dots, folds = File.read(file).split("\n\n")
      [
        dots.split("\n").map { |x| x.split(',').map(&:to_i) },
        folds.split("\n").map { |x| x.sub('fold along ', '').split('=').map { |y| y =~ /\d/ ? y.to_i : y.to_sym } }
      ]
    end
  end
end
