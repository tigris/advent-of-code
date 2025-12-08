# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      require 'puzzle_input'
      PuzzleInput.call('spec/fixtures/input.txt')
    end

    describe '.part1' do
      let(:expected_answer) { 1227775554 }

      it 'solves a simple range' do
        expect(described_class.part1(["11-22"])).to eq(33)
      end

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 4174379265 }

      it 'solves a simple range' do
        expect(described_class.part2(["998-1012"])).to eq(2009)
      end

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end

    describe '.match?' do
      it 'solves for a half split' do
        expect(described_class.match?("1212", 2)).to eq(true)
      end

      it 'solves for a tri split' do
        expect(described_class.match?("121212", 2)).to eq(true)
      end

      it 'fails on half split' do
        expect(described_class.match?("121212", 3)).to eq(false)
      end

      it 'fails on tri split' do
        expect(described_class.match?("998", 1)).to eq(false)
      end
    end
  end
end
