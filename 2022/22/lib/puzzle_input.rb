# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.read(file).split("\n\n").to_h do |line|
        if line =~ /\#/
          [:map, line.split("\n")]
        else
          [:moves, line.chomp.split(/(L|R)/).map do |c|
                     if c == 'L'
                       :left
                     else
                       c == 'R' ? :right : c.to_i
                     end
                   end]
        end
      end
    end
  end
end
