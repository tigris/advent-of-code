# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        %w[HN end],
        %w[HN start],
        %w[LN dc],
        %w[dc HN],
        %w[dc end],
        %w[dc start],
        %w[kj HN],
        %w[kj dc],
        %w[kj sa],
        %w[start kj]
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 19 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 103 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
