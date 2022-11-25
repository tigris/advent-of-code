# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to be_nil
      end
    end
  end
end
