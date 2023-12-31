# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        '467..114..',
        '...*......',
        '..35..633.',
        '......#...',
        '617*......',
        '.....+.58.',
        '..592.....',
        '......755.',
        '...$.*....',
        '.664.598..'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 4361 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 467_835 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
