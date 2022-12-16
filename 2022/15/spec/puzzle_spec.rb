# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
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

    describe '.part1' do
      let(:expected_answer) { 26 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input, 10)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 56_000_011 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input, 20)).to eq(expected_answer)
      end
    end
  end
end
