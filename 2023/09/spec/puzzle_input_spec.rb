# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        %w[0 3 6 9 12 15].map(&:to_i),
        %w[1 3 6 10 15 21].map(&:to_i),
        %w[10 13 16 21 30 45].map(&:to_i)
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
