# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:smaller_input) do
      [
        '.....',
        '..##.',
        '..#..',
        '.....',
        '..##.',
        '.....'
      ]
    end

    let(:provided_input) do
      [
        '....#..',
        '..###.#',
        '#...#.#',
        '.#...##',
        '#.###..',
        '##.#.##',
        '.#..#..'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 110 }

      it 'returns the correct result' do
        # expect(described_class.part1(smaller_input)).to eq(expected_answer)
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 20 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end