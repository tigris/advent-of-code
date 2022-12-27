# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        '1=-0-2',
        '12111',
        '2=0=',
        '21',
        '2=01',
        '111',
        '20012',
        '112',
        '1=-1=',
        '1-12',
        '12',
        '1=',
        '122'
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
