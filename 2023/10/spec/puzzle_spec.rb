# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        'FF7FSF7F7F7F7F7F---7'.chars,
        'L|LJ||||||||||||F--J'.chars,
        'FL-7LJLJ||||||LJL-77'.chars,
        'F--JF--7||LJLJ7F7FJ-'.chars,
        'L---JF-JLJ.||-FJLJJ7'.chars,
        '|F|F-JF---7F7-L7L|7|'.chars,
        '|FFJF7L7F-JF7|JL---7'.chars,
        '7-L-JL7||F7|L7F-7F7|'.chars,
        'L.L7LFJ|||||FJL7||LJ'.chars,
        'L7JLJL-JLJLJL--JLJ.L'.chars
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 8 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 10 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
