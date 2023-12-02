# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      {
        '1' => ' 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
        '2' => ' 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
        '3' => ' 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
        '4' => ' 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
        '5' => ' 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
      }
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
