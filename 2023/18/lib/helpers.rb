# frozen_string_literal: true

class Puzzle
  class Helpers
    class << self
      def hash_of_points(input, &blk)
        hash = {}
        input.each_with_index do |row, r|
          row.chars.each_with_index do |char, c|
            if block_given?
              hash[[r,c]] = yield(char)
            else
              hash[[r,c]] = char
            end
          end
        end
        hash
      end

      def print_matrix(input, file=false)
        stream = file ? File.open(file, 'w') : $stdout
        if input.is_a?(Hash)
          input.keys.sort.each{|r,c| stream.puts '' if c == 0 && r != 0 ; stream.print input[[r,c]] }
          stream.puts
        elsif input.is_a?(Array)
          input.each do |row|
            line = row.is_a?(Array) ? row.join : row
            stream.puts line
          end
        end
        stream.close if file
      end
    end
  end
end
