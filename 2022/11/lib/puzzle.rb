# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, times = 20, worry_reducer = 3)
      monkeys = input.map { |i| Monkey.new(i, worry_reducer) }
      monkeys.each { |m| m.all_monkeys = monkeys }

      times.times do |_x|
        # puts "Round: #{x}"
        monkeys.each_with_index do |monkey, _i|
          # puts "Monkey #{i}:"
          monkey.inspect!
        end
      end

      # puts monkeys.inspect
      sorted = monkeys.map(&:inspection_count).sort
      # puts monkeys.map{|x| x.inspection_count }.inspect
      sorted[-1] * sorted[-2]
    end

    def part2(input)
      part1(input, 10_000, 1)
    end
  end
end

# monkeys
class Monkey
  attr_reader :give_false, :give_true, :test, :operation, :inspection_count, :reducer
  attr_accessor :all_monkeys, :items

  def initialize(text, reducer)
    @inspection_count = 0
    @reducer = reducer
    @prime = nil
    parse!(text)
  end

  def parse!(input)
    input.split("\n").each do |line|
      case line
      when /If true: throw to monkey (\d+)$/
        @give_true = ::Regexp.last_match(1).to_i
      when /If false: throw to monkey (\d+)$/
        @give_false = ::Regexp.last_match(1).to_i
      when /Starting items: ([\d, ]+)$/
        @items = ::Regexp.last_match(1).split(',').map { |x| x.strip.to_i }
      when /Test: divisible by (\d+)$/
        @test = ::Regexp.last_match(1).to_i
      when /Operation: new = (.+)$/
        @operation = ::Regexp.last_match(1)
      end
    end
  end

  def operate(item)
    prime = @prime || all_monkeys.map(&:test).reduce(:*)
    # rubocop:disable Security/Eval
    eval(operation.gsub('old', item.to_s)).to_i % prime
    # rubocop:enable Security/Eval
  end

  def inspect!
    @items = items.each_with_index.map do |item|
      @inspection_count += 1
      # puts "  Monkey inspects an item with a worry level of #{item}."
      val = operate(item)
      # puts "    Worry level is `#{operation}` to #{val}"
      val /= reducer
      # puts "    Monkey gets bored with item. Worry level is divided by 3 to #{val}"
      if (val % test).zero?
        # puts "    Current worry level is divisible by #{test}."
        # puts "    Item with worry level #{val} is thrown to monkey #{give_true}."
        all_monkeys[give_true].items << val
      else
        # puts "    Current worry level is not divisible by #{test}."
        # puts "    Item with worry level #{val} is thrown to monkey #{give_false}."
        all_monkeys[give_false].items << val
      end
      nil
    end.compact
  end
end
