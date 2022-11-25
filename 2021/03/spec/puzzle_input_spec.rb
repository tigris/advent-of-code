# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(%w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010])
      end
    end
  end
end
