# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
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

    describe '.part1' do
      let(:expected_answer) { 17 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) do
        '
          #####
          #...#
          #...#
          #...#
          #####
          .....
          .....
        '.split.map(&:lstrip).join("\n")
      end

      it 'returns the correct result' do
        expect(described_class.part2(provided_input).strip).to eq(expected_answer.strip)
      end
    end
  end
end
