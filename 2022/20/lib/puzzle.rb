# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, times = 1)
      decrypted = decrypt(input, times)
      zero = decrypted.index(0)

      decrypted.values_at(
        (zero + 1000) % decrypted.length,
        (zero + 2000) % decrypted.length,
        (zero + 3000) % decrypted.length
      ).sum
    end

    def decrypt(input, times)
      items = input.each_with_index.map { |e, i| [e, i] }

      times.times do
        input.each_with_index do |e, i|
          current_index = items.index([e, i])
          items.delete_at(current_index)
          new_index = (current_index + e) % (input.length - 1)
          items.insert(new_index, [e, i])
        end
      end

      items.map(&:first)
    end

    def part2(input)
      part1(input.map { |x| x * 811_589_153 }, 10)
    end
  end
end
