# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        [Vector[0, 9], Vector[5, 9]],
        [Vector[8, 0], Vector[0, 8]],
        [Vector[9, 4], Vector[3, 4]],
        [Vector[2, 2], Vector[2, 1]],
        [Vector[7, 0], Vector[7, 4]],
        [Vector[6, 4], Vector[2, 0]],
        [Vector[0, 9], Vector[2, 9]],
        [Vector[3, 4], Vector[1, 4]],
        [Vector[0, 0], Vector[8, 8]],
        [Vector[5, 5], Vector[8, 2]]
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
