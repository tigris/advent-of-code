# frozen_string_literal: true

require 'chunky_png'
require 'set'

FILL = ['#d3d3d3', nil].freeze

# Advent of Code puzzle
class Puzzle
  class << self
    def pm(matrix, stream=$stdout)
      matrix.keys.sort.each{|r,c| stream.puts '' if c == 0 ; stream.print matrix[[r,c]] }
      stream.puts
    end

    def to_printable(matrix)
      width = matrix.keys.map(&:last).minmax
      length = matrix.keys.map(&:first).minmax

      print_png = false
      pixel_size = 15
      png = ChunkyPNG::Image.new((width[1] - width[0] + 1) * pixel_size, (length[1] - length[0] + 1) * pixel_size, :white)

      printable = {}

      (length[0]..length[1]).each_with_index do |r, y|
        (width[0]..width[1]).each_with_index do |c, x|
          if item = matrix[[r,c]]
            if print_png
              (1...pixel_size).each do |x1|
                (1...pixel_size).each do |y1|
                  png[(x*pixel_size)+x1,(y*pixel_size)+y1] = ChunkyPNG::Color.from_hex(item[0])
                end
              end
            end
            if item[1][0] == 'S'
              item[1] = item[1][1..].reverse
            end
            if item[1] == ['U', 'R'] || item[1] == ['L', 'D']
              printable[[y,x]] = 'F'
            elsif item[1] == ['U', 'L'] || item[1] == ['R', 'D']
              printable[[y,x]] = '7'
            elsif item[1] == ['L', 'U'] || item[1] == ['D', 'R']
              printable[[y,x]] = 'L'
            elsif item[1] == ['R', 'U'] || item[1] == ['D', 'L']
              printable[[y,x]] = 'J'
            elsif item[1] == ['U'] || item[1] == ['D']
              printable[[y,x]] = '|'
            elsif item[1] == ['R'] || item[1] == ['L']
              printable[[y,x]] = '-'
            end
          else
            printable[[y,x]] = '.'
          end
        end
      end

      png.save('puzzle.png') if print_png

      printable
    end

    def part1(input)
      matrix = {}
      vectors = Set.new
      position = [0,0]

      input.each_with_index do |instruction, i|
        direction, distance, color = instruction.split(/ /)

        new_r, new_c = position
        case direction
        when 'R' ; new_r += distance.to_i
        when 'L' ; new_r -= distance.to_i
        when 'U' ; new_c -= distance.to_i
        when 'D' ; new_c += distance.to_i
        end

        vector = [position, [new_r,new_c]]
        vectors << vector
        ver = [new_r, position[0]].sort
        hor = [new_c, position[1]].sort

        (ver[0]..ver[1]).each do |c|
          (hor[0]..hor[1]).each do |r|
            matrix[[r,c]] = [color.gsub(/[()]/, ''), ['S']] if i == 0 && r == hor[0] && c == ver[0]
            if existing = matrix[[r,c]]
              existing[1] << direction
            else
              matrix[[r,c]] = [color.gsub(/[()]/, ''), [direction]]
            end
          end
        end

        position = [new_r, new_c]
      end

      # fill!(matrix)
      new_matrix = to_printable(matrix)
      p 'calculating'
      new_matrix.keys.sort.each do |row, column|
        item = new_matrix[[row,column]]
        next unless item == '.'

        prev_item = new_matrix[[row,column-1]]
        if prev_item == 'I'
          new_matrix[[row,column]] = 'I'
        elsif prev_item == 'O'
          new_matrix[[row,column]] = 'O'
        else
          to_right = new_matrix.select{|k,v| k[0] == row && k[1] > column}
          north_blocks = to_right.values.select{|v| %w(L J S |).include?(v)}.size
          south_blocks = to_right.values.select{|v| %w(F 7 |).include?(v)}.size
          new_matrix[[row,column]] = [north_blocks, south_blocks].min.odd? ?  'I' : 'O'
        end
      end

      # File.open('output.txt', 'w') do |file|
        pm new_matrix#, file
      # end
      p 'done'

      new_matrix.values.reject{|x| x == 'O'}.count
    end

    def fill!(matrix)
      width = matrix.keys.map(&:last).minmax
      length = matrix.keys.map(&:first).minmax

      (length[0]..length[1]).each do |r|
        row_items = matrix.select{|k,v| k[0] == r && v[1] }

        (width[0]..width[1]).each do |c|
          current = matrix[[r,c]]
          next if current

          left = row_items.select{|k,v| k[1] < c }
          right = row_items.select{|k,v| k[1] > c }
          next unless left.size.odd? || right.size.odd?

          matrix[[r,c]] = FILL
        end
      end
    end

    def part2(input)
      new_input = []
      input.each do |line|
        _, _, color = line.split(/ /)
        distance, direction = color.match(/[(][#](\w{5})(\w)[)]$/).captures
        direction = ['R', 'D', 'L', 'U'][direction.to_i]
        distance = distance.to_i(16)

        new_input << [direction, distance]
      end

      p new_input.map(&:last).reduce(&:gcd)

      # part1(new_input)
    end
  end
end
