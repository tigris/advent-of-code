# frozen_string_literal: true

# It's a submarine, not built by ScoMo
class Submarine
  attr_reader :depth, :horizontal

  def initialize
    @depth = @horizontal = 0
  end

  def forward(amount)
    @horizontal += amount
  end

  def up(amount)
    @depth -= amount
  end

  def down(amount)
    @depth += amount
  end
end
