# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map do |line|
        # rubocop:disable Security/Eval
        eval(line.chomp)
        # rubocop:enable Security/Eval
      end.compact
    end
  end
end
