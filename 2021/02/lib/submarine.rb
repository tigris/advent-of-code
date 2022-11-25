# frozen_string_literal: true

# It's a submarine, not built by ScoMo
class Submarine
  attr_reader :aim, :depth, :horizontal

  def initialize
    @aim = @depth = @horizontal = 0
  end

  def forward(amount)
    @horizontal += amount
    @depth += (aim * amount)
  end

  def up(amount)
    @aim -= amount
  end

  def down(amount)
    @aim += amount
  end
end
