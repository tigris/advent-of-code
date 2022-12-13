# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        [1, 1, 3, 1, 1],
        [1, 1, 5, 1, 1],
        [[1], [2, 3, 4]],
        [[1], 4],
        [9],
        [[8, 7, 6]],
        [[4, 4], 4, 4],
        [[4, 4], 4, 4, 4],
        [7, 7, 7, 7],
        [7, 7, 7],
        [],
        [3],
        [[[]]],
        [[]],
        [1, [2, [3, [4, [5, 6, 7]]]], 8, 9],
        [1, [2, [3, [4, [5, 6, 0]]]], 8, 9]
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 13 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 140 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end

    describe '.sort' do
      it 'continues after array is equal' do
        l = [1, [1, 1], 2]
        r = [1, [1, 1], 1]
        expect(described_class.sort(l, r)).to eq(1)
      end

      # left array should cause a left winner here before the right wins in the last spot
      it 'bails early if array wins' do
        l = [1, [1, 1], 2]
        r = [1, [1, 2], 1]
        expect(described_class.sort(l, r)).to eq(-1)
      end

      it 'array wins if shorter' do
        l = [1, [1, 1], 2]
        r = [1, [1, 1, 3], 1]
        expect(described_class.sort(l, r)).to eq(-1)
      end
    end
  end
end
