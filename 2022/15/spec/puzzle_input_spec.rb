# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        { sensor: [2, 18], beacon: [-2, 15] },
        { sensor: [9, 16], beacon: [10, 16] },
        { sensor: [13, 2], beacon: [15, 3] },
        { sensor: [12, 14], beacon: [10, 16] },
        { sensor: [10, 20], beacon: [10, 16] },
        { sensor: [14, 17], beacon: [10, 16] },
        { sensor: [8, 7], beacon: [2, 10] },
        { sensor: [2, 0], beacon: [2, 10] },
        { sensor: [0, 11], beacon: [2, 10] },
        { sensor: [20, 14], beacon: [25, 17] },
        { sensor: [17, 20], beacon: [21, 22] },
        { sensor: [16, 7], beacon: [15, 3] },
        { sensor: [14, 3], beacon: [15, 3] },
        { sensor: [20, 1], beacon: [15, 3] }
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
