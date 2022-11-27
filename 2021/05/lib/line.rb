# frozen_string_literal: true

require 'matrix'

# A line has a start point and an end point, it is straight
class Line
  attr_reader :points

  def initialize(start, finish)
    # force lines into always going forward or down
    start, finish = finish, start if (finish[0] < start[0]) || (finish[1] < start[1])

    @horizontal = start[1] == finish[1]
    @vertical = start[0] == finish[0]

    @points = []
    (start[0]..finish[0]).each { |x| @points << Vector[x, start[1]] }
    (start[1]..finish[1]).each { |y| @points << Vector[start[0], y] }
    @points.uniq!
  end

  def horizontal? = @horizontal
  def vertical? = @vertical
end
