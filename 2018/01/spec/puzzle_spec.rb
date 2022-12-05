# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    describe '.part1' do
      let(:provided_input) do
        [1, 2, -4]
      end
      let(:expected_answer) { -1 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:provided_input) do
        [1, -2, 3, 1, 1, -2]
      end
      let(:expected_answer) { 2 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
