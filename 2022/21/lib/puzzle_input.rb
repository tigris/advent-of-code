# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file, chomp: true).to_h do |line|
        name, answer = line.split(': ')

        answer = if answer =~ /^(\w+) (.) (\w+)$/
                   Regexp.last_match[-3..].map(&:to_sym)
                 else
                   answer.to_f
                 end

        [name.to_sym, answer]
      end
    end
  end
end
