# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(File.expand_path(File.dirname(__FILE__)), 'fixtures', 'input.txt') }

    describe '.call' do
      it 'returns the correct array' do
        expect(described_class.call(filename)).to eq([1, 2, 3])
      end
    end
  end
end
