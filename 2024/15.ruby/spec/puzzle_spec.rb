# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      require 'puzzle_input'
      PuzzleInput.call('spec/fixtures/input.txt')
    end

    describe '.part1 small' do
      let(:provided_input) do
        require 'puzzle_input'
        PuzzleInput.call('spec/fixtures/input_small.txt')
      end

      let(:expected_answer) { 2028 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part1 big' do
      let(:expected_answer) { 10_092 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2 small' do
      let(:provided_input) do
        require 'puzzle_input'
        PuzzleInput.call('spec/fixtures/input_small_2.txt')
      end

      let(:expected_answer) { 618 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2 big' do
      let(:expected_answer) { 9021 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
