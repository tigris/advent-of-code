# frozen_string_literal: true

# This is required purely for use of the in memory object id, so we can fetch it
# out of an array when 2 values are the same
class Item
  attr_accessor :value, :index

  def initialize(value, index)
    @value = value
    @index = index
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, times = 1)
      decrypted = decrypt(input, times).cycle
      # p decrypted

      decrypted.next while decrypted.peek != 0

      1000.times { decrypted.next }
      one = decrypted.peek
      1000.times { decrypted.next }
      two = decrypted.peek
      1000.times { decrypted.next }
      three = decrypted.peek

      one + two + three
    end

    def decrypt(input, times)
      items = input.each_with_index.map { |e, i| Item.new(e, i) }

      # p "Initial #{items.map{|x| x.value }}"

      times.times do
        input.each_with_index do |e, i|
          item = items.find { |x| x.value == e && x.index == i }
          current_index = items.index(item)
          items.delete_at(current_index)
          new_index = (current_index + item.value) % (input.length - 1)
          items.insert(new_index, item)
          # p "Processed #{e}: #{items.map{|x| x.value }}"
        end
      end

      items.map(&:value)
    end

    def part2(input)
      part1(input.map { |x| x * 811_589_153 }, 10)
    end
  end
end
