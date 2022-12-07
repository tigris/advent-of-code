# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        [
          [6, 10],
          [0, 14],
          [9, 10],
          [0, 3],
          [10, 4],
          [4, 11],
          [6, 0],
          [6, 12],
          [4, 1],
          [0, 13],
          [10, 12],
          [3, 4],
          [3, 0],
          [8, 4],
          [1, 10],
          [2, 14],
          [8, 10],
          [9, 0]
        ],
        [
          [:y, 7],
          [:x, 5]
        ]
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
