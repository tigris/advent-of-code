# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      require 'puzzle_input'
      PuzzleInput.call('spec/fixtures/input.txt')
    end

    describe '.part1 easy' do
      let(:expected_answer) { 140 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part1 medium' do
      let(:provided_input) do
        require 'puzzle_input'
        PuzzleInput.call('spec/fixtures/input2.txt')
      end

      let(:expected_answer) { 772 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part1 hard' do
      let(:provided_input) do
        require 'puzzle_input'
        PuzzleInput.call('spec/fixtures/input3.txt')
      end

      let(:expected_answer) { 1930 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 80 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
