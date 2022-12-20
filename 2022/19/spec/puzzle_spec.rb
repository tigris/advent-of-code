# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        {
          ore: { ore: 4 },
          clay: { ore: 2 },
          obsidian: { ore: 3, clay: 14 },
          geode: { ore: 2, obsidian: 7 },
          max: { ore: 4, clay: 14, obsidian: 7, geode: 10 }
        },
        {
          ore: { ore: 2 },
          clay: { ore: 3 },
          obsidian: { ore: 3, clay: 8 },
          geode: { ore: 3, obsidian: 12 },
          max: { ore: 3, clay: 8, obsidian: 12, geode: 10 }
        }
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 33 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 56 * 62 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
