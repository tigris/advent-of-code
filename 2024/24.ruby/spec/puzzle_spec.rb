# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      require 'puzzle_input'
      PuzzleInput.call('spec/fixtures/input.txt')
    end

    describe '.part1' do
      let(:expected_answer) { 4 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part1 bigger' do
      let(:provided_input) do
        require 'puzzle_input'
        PuzzleInput.call('spec/fixtures/input2.txt')
      end

      let(:expected_answer) { 2024 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    xdescribe '.part2' do
      let(:provided_input) do
        require 'puzzle_input'
        PuzzleInput.call('spec/fixtures/input3.txt')
      end

      let(:expected_answer) { 'z00,z01,z02,z05' }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
