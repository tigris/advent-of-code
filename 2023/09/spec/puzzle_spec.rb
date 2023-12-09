# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        %w(0 3 6 9 12 15).map(&:to_i),
        %w(1 3 6 10 15 21).map(&:to_i),
        %w(10 13 16 21 30 45).map(&:to_i)
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 114 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 2 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
