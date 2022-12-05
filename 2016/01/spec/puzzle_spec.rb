# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    describe '.part1' do
      let(:provided_inputs) do
        [
          %w(R2 L3),
          %w(R2 R2 R2),
          %w(R5 L5 R5 R3),
        ]
      end
      let(:expected_answers) { [5, 2, 12] }

      it 'returns the correct result' do
        expect(described_class.part1(provided_inputs[0])).to eq(expected_answers[0])
      end
      it 'returns the correct result' do
        expect(described_class.part1(provided_inputs[1])).to eq(expected_answers[1])
      end
      it 'returns the correct result' do
        expect(described_class.part1(provided_inputs[2])).to eq(expected_answers[2])
      end
    end

    describe '.part2' do
      let(:provided_input) { %w(R8 R4 R4 R8) }
      let(:expected_answer) { 4 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
