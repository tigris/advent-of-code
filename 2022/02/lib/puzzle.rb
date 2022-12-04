# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      match_points  = { win: 6, draw: 3, loss: 0 }
      choice_points = { rock: 1, paper: 2, scissors: 3 }

      opp_choices = { A: :rock, B: :paper, C: :scissors }
      my_choices  = { Z: :scissors, Y: :paper, X: :rock }

      winners = [%i[rock paper], %i[scissors rock], %i[paper scissors]]

      input.map { |x, y| [opp_choices[x], my_choices[y]] }.map do |opp, me|
        match_result = if opp == me
                         :draw
                       elsif winners.include?([opp, me])
                         :win
                       else
                         :loss
                       end

        match_points[match_result] + choice_points[me]
      end.sum
    end

    def part2(input)
      match_points  = { win: 6, draw: 3, loss: 0 }
      choice_points = { rock: 1, paper: 2, scissors: 3 }

      opp_choices = { A: :rock, B: :paper, C: :scissors }
      match_results = { Y: :draw, X: :loss, Z: :win }

      winners = [%i[rock paper], %i[scissors rock], %i[paper scissors]]

      input.map { |x, y| [opp_choices[x], match_results[y]] }.map do |opp, match_result|
        me = case match_result
             when :draw
               opp
             when :win
               winners.find { |winner, _loser| winner == opp }[1]
             else
               winners.find { |_winner, loser| loser == opp }[0]
             end

        match_points[match_result] + choice_points[me]
      end.sum
    end
  end
end
