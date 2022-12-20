# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
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

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
