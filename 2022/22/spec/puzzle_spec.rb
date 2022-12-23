# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
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

    describe '.part1' do
      let(:expected_answer) { 6032 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    # describe '.part2' do
    #   let(:expected_answer) { 5031 }
    #
    #   it 'returns the correct result' do
    #     expect(described_class.part2(provided_input)).to eq(expected_answer)
    #   end
    # end
  end
end
