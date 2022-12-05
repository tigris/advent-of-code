# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      {
        stacks: [%w[N Z], %w[D C M], %w[P]],
        moves: [[1, 2, 1], [3, 1, 3], [2, 2, 1], [1, 1, 2]]
      }
    end

    describe '.part1' do
      let(:expected_answer) { 'CMZ' }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 'MCD' }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
