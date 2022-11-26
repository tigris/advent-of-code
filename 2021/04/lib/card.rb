# frozen_string_literal: true

# A bingo card
class Card
  attr_reader :games

  def initialize(rows)
    @games = rows + (0..rows[0].length - 1).map { |x| rows.map { |r| r[x] } }
  end

  def remove_number(number)
    @games.each { |game| game.delete(number) }
    @games.any?(&:empty?)
  end

  def sum_numbers
    @games.inject(0) { |sum, game| sum + game.sum } / 2
  end
end
