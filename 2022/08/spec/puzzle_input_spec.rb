# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        '30373'.chars.map(&:to_i),
        '25512'.chars.map(&:to_i),
        '65332'.chars.map(&:to_i),
        '33549'.chars.map(&:to_i),
        '35390'.chars.map(&:to_i)
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
