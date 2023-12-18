# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        '#.#.### 1,1,3',
        '.#...#....###. 1,1,3',
        '.#.###.#.###### 1,3,1,6',
        '####.#...#... 4,1,1',
        '#....######..#####. 1,6,5',
        '.###.##....# 3,2,1'
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
