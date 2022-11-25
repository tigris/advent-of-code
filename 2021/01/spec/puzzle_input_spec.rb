# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }

    describe '.call' do
      it 'returns the correct array' do
        expect(described_class.call(filename)).to eq([1, 2, 3])
      end
    end
  end
end
