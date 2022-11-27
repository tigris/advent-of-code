# frozen_string_literal: true

require 'matrix'

# A line has a start point and an end point, it is straight
class Line
  attr_reader :start, :finish

  def initialize(start, finish)
    # force lines into always going forward or down
    start, finish = finish, start if (finish[0] < start[0]) || (finish[1] < start[1])

    @start = start
    @finish = finish
  end

  def horizontal?
    start[1] == finish[1]
  end

  def vertical?
    start[0] == finish[0]
  end

  def diagonal?
    (finish[0] - start[0]).abs == (finish[1] - start[1]).abs
  end

  def points
    if horizontal?
      horizontal_points
    elsif vertical?
      vertical_points
    elsif diagonal?
      diagonal_points
    end
  end

  private

  def horizontal_points
    (start[0]..finish[0]).map { |x| Vector[x, start[1]] }
  end

  def vertical_points
    (start[1]..finish[1]).map { |y| Vector[start[0], y] }
  end

  def diagonal_points
    ((finish[0] - start[0]).abs + 1).times.map do |i|
      x = finish[0] > start[0] ? start[0] + i : start[0] - i
      y = finish[1] > start[1] ? start[1] + i : start[1] - i
      Vector[x, y]
    end
  end
end
