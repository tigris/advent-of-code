# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        %q(.|...\....),
        %q(|.-.\.....),
        '.....|-...',
        '........|.',
        '..........',
        %(.........\\),
        %(..../.\\\\..),
        '.-.-/..|..',
        %(.|....-|.\\),
        '..//.|....'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 46 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 51 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
