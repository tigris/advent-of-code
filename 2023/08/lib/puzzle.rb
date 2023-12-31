# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      moves_for(input, /AAA/, /ZZZ/)
    end

    def part2(input)
      moves_for(input, /A$/, /Z$/)
      # steps(input, /A$/, /Z$/)
    end

    # just a test method to find a pattern, guess what, it was easy actually
    def steps(input, start_re, finish_re)
      positions = input.keys.select { |k| start_re.match?(k) }
      search = input['moves'].map { |d| d == 'L' ? 0 : 1 }.cycle

      finished_moves = {}
      positions.each do |position|
        starting = position
        moves = 0
        catch(:looped) do
          while true
            input['moves'].each_with_index do |move, i|
              moves += 1
              position = input[position][move == 'L' ? 0 : 1]
              next unless finish_re.match?(position)

              finished_identifier = [starting, position, i]
              if finished_moves[finished_identifier]
                puts "#{starting} found #{position} at move index #{i} after #{moves} moves and completing"
                puts " ===> next would be #{input[position][0]}"
                throw(:looped)
              end
              puts "#{starting} found #{position} at move index #{i} after #{moves} moves but continuuing"
              finished_moves[finished_identifier] = moves
            end
          end
        end
      end

      p finished_moves
    end

    def moves_for(input, start_re, finish_re)
      search = input['moves'].map { |d| d == 'L' ? 0 : 1 }.cycle

      positions = input.keys.select { |k| start_re.match?(k) }
      moves_for = positions.map do |position|
        moves = 0
        until finish_re.match?(position)
          moves += 1
          position = input[position][search.next]
        end
        moves
      end

      moves_for.reduce(&:lcm)
    end
  end
end
