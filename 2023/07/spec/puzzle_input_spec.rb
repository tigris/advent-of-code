# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        %w[32T3K 765],
        %w[T55J5 684],
        %w[KK677 28],
        %w[KTJJT 220],
        %w[QQQJA 483]
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
