# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp).chunk(&:empty?).map do |_, lines|
        next if lines[0] == ''

        a = lines[0].match(/A: X\+(\d+), Y\+(\d+)$/)
        b = lines[1].match(/B: X\+(\d+), Y\+(\d+)$/)
        p = lines[2].match(/Prize: X=(\d+), Y=(\d+)$/)

        {
          a: [a[1].to_f, a[2].to_f],
          b: [b[1].to_f, b[2].to_f],
          p: [p[1].to_f, p[2].to_f]
        }
      end.compact
    end
  end
end
