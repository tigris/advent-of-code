# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def pm(matrix)
      matrix.keys.sort.each{|r,c| puts '' if c == 0 ; print matrix[[r,c]] }
      puts
    end

    def part1(input, modifier=2)
      matrix = {}

      expand(input).each_with_index do |row, r|
        row.chars.each_with_index do |item, c|
          matrix[[r,c]] = item
        end
      end

      pairs = []
      galaxies = matrix.select{|_,v| v == '#' }.keys
      (0...galaxies.length-1).each do |i|
        (i+1...galaxies.length).each do |j|
          pairs << [galaxies[i],galaxies[j]]
        end
      end

      pairs.map{|left, right| straight_distance(matrix, left, right, modifier) }.sum
    end

    def straight_distance(matrix, start, finish, modifier)
      # row_steps = matrix.select{|k,v| Range.new(*[start, finish].map(&:first).sort, true).cover?(k[0]) && k[1] == start[1] }
      # column_steps = matrix.select{|k,v| Range.new(*[start, finish].map(&:last).sort, true).cover?(k[1]) && k[0] == finish[0] }
      steps = []
      pos = start
      while pos != finish
        if pos[0] > finish[0]
          pos = [pos[0]-1,pos[1]]
        elsif pos[0] < finish[0]
          pos = [pos[0]+1,pos[1]]
        elsif pos[1] > finish[1]
          pos = [pos[0],pos[1]-1]
        elsif pos[1] < finish[1]
          pos = [pos[0],pos[1]+1]
        end
        steps << pos
      end

      # puts "#{start.inspect} -> #{finish.inspect} == #{steps.map{|s| matrix[s] == 'x' ? modifier : 1 }.sum}"
      # stepped = matrix.dup
      # steps.each{|k| stepped[k] = matrix[k] == 'x' ? 'S' : 's' }
      # pm stepped

      steps.map{|s| matrix[s] == 'x' ? modifier : 1 }.sum
    end

    def expand(input)
      expanded_rows = input.map.with_index do |row, r|
        row =~ /#/ ? row : 'x'*row.length
      end

      expanded_cols = Array.new(expanded_rows.length) { '' }
      (0...expanded_rows[0].length).each do |c|
        if expanded_rows.map{|x| x[c] }.join =~ /#/
          expanded_cols.map!.with_index{|x, r| x + expanded_rows[r][c] }
        else
          expanded_cols.map!.with_index{|x, r| x + 'x' }
        end
      end
      expanded_cols
    end

    def part2(input)
      part1(input, 1_000_000)
    end
  end
end
