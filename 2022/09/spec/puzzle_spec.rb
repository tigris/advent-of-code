# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        %w[R 4],
        %w[U 4],
        %w[L 3],
        %w[D 1],
        %w[R 4],
        %w[D 1],
        %w[L 5],
        %w[R 2]
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 13 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:provided_input) do
        [
          %w[R 5],
          %w[U 8],
          %w[L 8],
          %w[D 3],
          %w[R 17],
          %w[D 10],
          %w[L 25],
          %w[U 20]
        ]
      end
      let(:expected_answer) { 36 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
