# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        [2..4, 6..8],
        [2..3, 4..5],
        [5..7, 7..9],
        [2..8, 3..7],
        [6..6, 4..6],
        [2..6, 4..8]
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 2 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 4 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
