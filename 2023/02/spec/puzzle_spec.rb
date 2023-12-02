# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      {
        '1' => ' 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
        '2' => ' 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
        '3' => ' 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
        '4' => ' 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
        '5' => ' 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
      }
    end

    describe '.part1' do
      let(:expected_answer) { 8 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 2286 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
