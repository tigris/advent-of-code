# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        [2, 2, 2],
        [1, 2, 2],
        [3, 2, 2],
        [2, 1, 2],
        [2, 3, 2],
        [2, 2, 1],
        [2, 2, 3],
        [2, 2, 4],
        [2, 2, 6],
        [1, 2, 5],
        [3, 2, 5],
        [2, 1, 5],
        [2, 3, 5]
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
