# frozen_string_literal: true

# Magic Calculator
class Calculator
  ADV = 0
  BXL = 1
  BST = 2
  JNZ = 3
  BXC = 4
  OUT = 5
  BDV = 6
  CDV = 7

  attr_accessor :register_a, :register_b, :register_c, :output

  def initialize(register_a: 0, register_b: 0, register_c: 0, program: [], must_match: [])
    @register_a = register_a
    @register_b = register_b
    @register_c = register_c
    @program = program
    @pointer = 0
    @output = []
    @must_match = must_match.freeze
    @seen = {}
  end

  def run!
    seen = {}

    while @pointer < @program.size
      return finalize_output if seen[[@pointer, @register_a, @register_b, @register_c]] || seen.size > 1_000_000

      seen[[@pointer, @register_a, @register_b, @register_c]] = true

      opscode, operand = @program[@pointer, 2]
      return finalize_output if halt_conditions_met?

      advance = execute_instruction(opscode, operand)
      @pointer += advance
    end

    finalize_output
  end

  private

  def combo_operand(operand)
    case operand
    when 4 then @register_a
    when 5 then @register_b
    when 6 then @register_c
    else operand
    end
  end

  def adv(operand)
    @register_a /= (1 << combo_operand(operand))
  end

  def bxl(operand)
    @register_b ^= operand
  end

  def bst(operand)
    @register_b = combo_operand(operand) % 8
  end

  def jnz(operand)
    return 2 if @register_a.zero?

    @pointer = operand
    0
  end

  def bxc(_operand)
    @register_b ^= @register_c
  end

  def out(operand)
    @output << (combo_operand(operand) % 8)
  end

  def bdv(operand)
    @register_b = @register_a / (1 << combo_operand(operand))
  end

  def cdv(operand)
    @register_c = @register_a / (1 << combo_operand(operand))
  end

  def halt_conditions_met?
    return false if @must_match.empty?
    return true if @output.size > @must_match.size

    @must_match[0...@output.size] != @output
  end

  def execute_instruction(opscode, operand)
    case opscode
    when ADV then adv(operand)
    when BXL then bxl(operand)
    when BST then bst(operand)
    when JNZ then return jnz(operand)
    when BXC then bxc(operand)
    when OUT then out(operand)
    when BDV then bdv(operand)
    when CDV then cdv(operand)
    else return finalize_output
    end
    2
  end

  def finalize_output
    @output.join(',')
  end
end

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      calculator = Calculator.new(
        register_a: input[0].gsub(/[^0-9]/, '').to_i,
        program: input[4].sub(/^Program: /, '').split(',').map(&:to_i)
      )
      calculator.run!
    end

    def part2(input)
      program = input[4].sub(/^Program: /, '').split(',').map(&:to_i)

      (0..1_000_000_000_000).each do |attempt|
        calculator = Calculator.new(register_a: attempt, program: program, must_match: program)
        return attempt if calculator.run! == program.join(',')
      end

      'No solution found'
    end
  end
end
