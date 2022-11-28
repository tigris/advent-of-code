# frozen_string_literal: true

# A lanternfish
class Fish
  attr_reader :timer

  def initialize(timer = 8)
    @timer = timer
  end

  def reduce!
    @timer -= 1
    return if @timer >= 0

    @timer = 6
    self.class.new
  end
end
