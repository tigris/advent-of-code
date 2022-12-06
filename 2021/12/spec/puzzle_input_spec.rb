# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        %w[dc end],
        %w[HN start],
        %w[start kj],
        %w[dc start],
        %w[dc HN],
        %w[LN dc],
        %w[HN end],
        %w[kj sa],
        %w[kj HN],
        %w[kj dc]
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
