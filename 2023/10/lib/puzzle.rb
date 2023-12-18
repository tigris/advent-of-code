# frozen_string_literal: true
class SearchItem
  attr_accessor :row, :column, :moves, :char
  def initialize(row, column, moves, char)
    @row = row
    @column = column
    @moves = moves
    @char = char
  end

  def position
    [row,column,char]
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def pm(matrix)
      matrix.keys.sort.each{|r,c| puts '' if c == 0 ; print matrix[[r,c]] }
      puts
    end

    def find_pipe(input)
      matrix = {}

      input.each_with_index do |row, i|
        row.each_with_index do |item, j|
          matrix[[i,j]] = item
        end
      end

      start = matrix.invert['S']
      search = [SearchItem.new(start[0], start[1], 0, 'S')]
      pipe = Hash.new(0)

      while !search.empty?
        current = search.shift

        if pipe[current.position] > current.moves || pipe[current.position] == 0
          pipe[current.position] = current.moves
        elsif pipe[current.position] > 0
          next
        end

        neighbours = [
          above(current, matrix),
          below(current, matrix),
          left(current, matrix),
          right(current, matrix)
        ]

        search += neighbours.compact
      end

      pipe
    end

    def part1(input)
      find_pipe(input).values.max
    end

    def above(node, matrix)
      other = matrix[[node.row-1,node.column]]
      case
      when other.nil? ; nil
      when %w(S | L J).include?(node.char) && %w(| F 7).none?(other) ; nil
      when %w(F 7 -).include?(node.char) ; nil
      else SearchItem.new(node.row - 1, node.column, node.moves + 1, other)
      end
    end

    def below(node, matrix)
      other = matrix[[node.row+1,node.column]]
      case
      when other.nil? ; nil
      when %w(S | F 7).include?(node.char) && %w(| J L).none?(other) ; nil
      when %w(J L -).include?(node.char) ; nil
      else SearchItem.new(node.row + 1, node.column, node.moves + 1, other)
      end
    end

    def left(node, matrix)
      other = matrix[[node.row,node.column-1]]
      case
      when other.nil? ; nil
      when %w(S - J 7).include?(node.char) && %w(- L F).none?(other) ; nil
      when %w(L F |).include?(node.char) ; nil
      else SearchItem.new(node.row, node.column - 1, node.moves + 1, other)
      end
    end

    def right(node, matrix)
      other = matrix[[node.row,node.column+1]]
      case
      when other.nil? ; nil
      when %w(S - F L).include?(node.char) && %w(- J 7).none?(other) ; nil
      when %w(7 J |).include?(node.char) ; nil
      else SearchItem.new(node.row, node.column + 1, node.moves + 1, other)
      end
    end

    def part2(input)
      matrix = {}.tap{|x| find_pipe(input).keys.each{|r,c,l| x[[r,c]] = l } }
      input.each_with_index do |_, row|
        input[row].each_with_index do |_, col|
          matrix[[row,col]] ||= '.'
        end
      end

      pm matrix

      matrix.each do |(row, column), item|
        next unless item == '.'
        to_right = matrix.select{|k,v| k[0] == row && k[1] > column}
        north_blocks = to_right.values.select{|v| %w(L J S |).include?(v)}.size
        south_blocks = to_right.values.select{|v| %w(F 7 |).include?(v)}.size

        matrix[[row,column]] = [north_blocks, south_blocks].min.odd? ?  'I' : 'O'
      end

      pm matrix

      matrix.values.count('I')
    end
  end
end
