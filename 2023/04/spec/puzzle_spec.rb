# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        [ %w(41 48 83 86 17).map(&:to_i), %w(83 86  6 31 17  9 48 53).map(&:to_i) ],
        [ %w(13 32 20 16 61).map(&:to_i), %w(61 30 68 82 17 32 24 19).map(&:to_i) ],
        [ %w(1 21 53 59 44).map(&:to_i), %w(69 82 63 72 16 21 14 1).map(&:to_i) ],
        [ %w(41 92 73 84 69).map(&:to_i), %w(59 84 76 51 58  5 54 83).map(&:to_i) ],
        [ %w(87 83 26 28 32).map(&:to_i), %w(88 30 70 12 93 22 82 36).map(&:to_i) ],
        [ %w(31 18 13 56 72).map(&:to_i), %w(74 77 10 23 35 67 36 11).map(&:to_i) ]
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 13 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 30 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
