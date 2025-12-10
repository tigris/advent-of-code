# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      require 'puzzle_input'
      PuzzleInput.call('spec/fixtures/input.txt')
    end

    describe '.joltage' do
      it 'solves a simple bank' do
        expect(described_class.joltage('987654321111111'.chars.map(&:to_i), 2)).to eq(98)
      end

      it 'solves a less simple bank' do
        expect(described_class.joltage('811111111111119'.chars.map(&:to_i), 2)).to eq(89)
      end

      it 'solves a simple bank with a bigger size' do
        expect(described_class.joltage('987654321111111'.chars.map(&:to_i), 12)).to eq(987_654_321_111)
      end

      it 'solves a less simple bank with a bigger size' do
        expect(described_class.joltage('811111111111119'.chars.map(&:to_i), 12)).to eq(811_111_111_119)
      end
    end

    describe '.part1' do
      let(:expected_answer) { 357 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 3_121_910_778_619 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
