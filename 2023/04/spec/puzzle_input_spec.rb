# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        [%w[41 48 83 86 17].map(&:to_i), %w[83 86 6 31 17 9 48 53].map(&:to_i)],
        [%w[13 32 20 16 61].map(&:to_i), %w[61 30 68 82 17 32 24 19].map(&:to_i)],
        [%w[1 21 53 59 44].map(&:to_i), %w[69 82 63 72 16 21 14 1].map(&:to_i)],
        [%w[41 92 73 84 69].map(&:to_i), %w[59 84 76 51 58 5 54 83].map(&:to_i)],
        [%w[87 83 26 28 32].map(&:to_i), %w[88 30 70 12 93 22 82 36].map(&:to_i)],
        [%w[31 18 13 56 72].map(&:to_i), %w[74 77 10 23 35 67 36 11].map(&:to_i)]
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
