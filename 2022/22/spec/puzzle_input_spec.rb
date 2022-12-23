# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      {
        map: [
          '        ...#',
          '        .#..',
          '        #...',
          '        ....',
          '...#.......#',
          '........#...',
          '..#....#....',
          '..........#.',
          '        ...#....',
          '        .....#..',
          '        .#......',
          '        ......#.'
        ],
        moves: [10, :right, 5, :left, 5, :right, 10, :left, 4, :right, 5, :left, 5]
      }
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
