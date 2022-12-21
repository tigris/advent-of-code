# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      data = {}
      File.readlines(file).map(&:chomp).each do |line|
        case line
        when /^(\w+): (\d+)$/
          data[Regexp.last_match[1].to_sym] = Regexp.last_match[2].to_f
        when /^(\w+): (\w+) (.) (\w+)$/
          data[Regexp.last_match[1].to_sym] = [Regexp.last_match[2], Regexp.last_match[3], Regexp.last_match[4]].map(&:to_sym)
        else
          throw :whoa
        end
      end
      data
    end
  end
end
