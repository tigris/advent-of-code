# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        '5483143223'.chars.map(&:to_i),
        '2745854711'.chars.map(&:to_i),
        '5264556173'.chars.map(&:to_i),
        '6141336146'.chars.map(&:to_i),
        '6357385478'.chars.map(&:to_i),
        '4167524645'.chars.map(&:to_i),
        '2176841721'.chars.map(&:to_i),
        '6882881134'.chars.map(&:to_i),
        '4846848554'.chars.map(&:to_i),
        '5283751526'.chars.map(&:to_i)
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 1656 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 195 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
