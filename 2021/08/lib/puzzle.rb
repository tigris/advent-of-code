# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def call(input)
      seen = 0
      input.each do |signals, outputs|
        seen += outputs.map{|x| to_number(x) }.compact.size
      end
      seen
    end

    def to_number(code)
      case code.length
      when 2 then 1
      when 3 then 7
      when 4 then 4
      when 7 then 8
      else nil
      end
    end
  end
end
