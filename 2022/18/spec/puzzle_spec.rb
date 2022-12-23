# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
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

    describe '.part1' do
      let(:expected_answer) { 64 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    # describe '.part2' do
    #   let(:expected_answer) { 58 }
    #
    #   it 'returns the correct result' do
    #     expect(described_class.part2(provided_input)).to eq(expected_answer)
    #   end
    # end
  end
end
