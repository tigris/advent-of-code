# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      {
        stacks: [%w[N Z], %w[D C M], %w[P]],
        moves: [[1, 2, 1], [3, 1, 3], [2, 2, 1], [1, 1, 2]]
      }
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
