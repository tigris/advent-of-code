# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      visible = []

      input.each_with_index do |row, r|
        row.each_with_index do |_col, c|
          visible << [r, c] if visible?(input, r, c)
        end
      end

      visible.size
    end

    def visible?(input, r, c)
      visible_left?(input, r, c) || visible_right?(input, r, c) || visible_top?(input, r, c) || visible_bottom?(input, r, c)
    end

    def visible_left?(input, r, c)
      return true if c.zero?

      (0..c - 1).to_a.all? { |i| input[r][i] < input[r][c] }
    end

    def visible_right?(input, r, c)
      return true if c == input[r].length - 1

      (c + 1..input[r].length - 1).to_a.all? { |i| input[r][i] < input[r][c] }
    end

    def visible_top?(input, r, c)
      return true if r.zero?

      col_vals = input.map { |x| x[c] }
      col_vals[0..r - 1].all? do |x|
        x < input[r][c]
      end
      # puts a if r == 1 and c == 3
    end

    def visible_bottom?(input, r, c)
      return true if r == input.length - 1

      col_vals = input.map { |x| x[c] }
      col_vals[r + 1..input.length - 1].all? { |x| x < input[r][c] }
    end

    def calc_score(input, r, c)
      left = score_left(input, r, c)
      right = score_right(input, r, c)
      up = score_up(input, r, c)
      down = score_down(input, r, c)

      # puts [r, c,  left, right, up, down ].inspect
      [left, right, up, down].reduce(:*)
    end

    def score_left(input, r, c)
      return 0 if c.zero?

      score = 0
      (0..c - 1).to_a.reverse.each do |x|
        score += 1
        return score if input[r][x] >= input[r][c]
      end

      score
    end

    def score_right(input, r, c)
      return 0 if c == input[r].length - 1

      score = 0
      (c + 1..input[r].length - 1).each do |x|
        score += 1
        return score if input[r][x] >= input[r][c]
      end

      score
    end

    def score_up(input, r, c)
      return 0 if r.zero?

      score = 0
      (0..r - 1).to_a.reverse.each do |x|
        score += 1
        return score if input[x][c] >= input[r][c]
      end

      score
    end

    def score_down(input, r, c)
      return 0 if r == input.length - 1

      score = 0
      (r + 1..input.length - 1).each do |x|
        score += 1
        return score if input[x][c] >= input[r][c]
      end

      score
    end

    def part2(input)
      scores = {}

      input.each_with_index do |row, r|
        row.each_with_index do |_col, c|
          scores[[r, c]] = calc_score(input, r, c)
        end
      end

      scores.values.max
    end
  end
end
