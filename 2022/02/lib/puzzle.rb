# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      match_points  = { win: 6, draw: 3, loss: 0 }
      choice_points = { rock: 1, paper: 2, scissors: 3 }

      opp_choices = { A: :rock, B: :paper, C: :scissors }
      my_choices  = { Z: :scissors, Y: :paper, X: :rock }

      input.map{|x,y| [ opp_choices[x], my_choices[y] ]}.map do |opp, me|
        match_result = case
          when opp == me then :draw
          when opp == :rock && me == :paper then :win
          when opp == :scissors && me == :rock then :win
          when opp == :paper && me == :scissors then :win
          else :loss
        end

        match_points[match_result] + choice_points[me]
      end.sum
    end

    def part2(input)
      match_points  = { win: 6, draw: 3, loss: 0 }
      choice_points = { rock: 1, paper: 2, scissors: 3 }

      opp_choices = { A: :rock, B: :paper, C: :scissors }
      match_results = { Y: :draw, X: :loss, Z: :win }

      input.map{|x,y| [ opp_choices[x], match_results[y] ]}.map do |opp, match_result|
        me = case
          when match_result == :draw then opp
          when match_result == :loss && opp == :paper then :rock
          when match_result == :loss && opp == :rock then :scissors
          when match_result == :loss && opp == :scissors then :paper
          when match_result == :win && opp == :rock then :paper
          when match_result == :win && opp == :paper then :scissors
          when match_result == :win && opp == :scissors then :rock
        end

        match_points[match_result] + choice_points[me]
      end.sum
    end
  end
end
