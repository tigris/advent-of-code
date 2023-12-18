# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        'rn=1',
        'cm-',
        'qp=3',
        'cm=2',
        'qp-',
        'pc=4',
        'ot=9',
        'ab=5',
        'pc-',
        'pc=6',
        'ot=7'
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
