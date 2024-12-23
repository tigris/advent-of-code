# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      require 'puzzle_input'
      Puzzle::Input.call('spec/fixtures/input.txt')
    end

    let(:provided_input2) do
      require 'puzzle_input'
      Puzzle::Input.call('spec/fixtures/input2.txt')
    end

    describe '.part1' do
      let(:expected_answer) { 7036 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part1 other' do
      let(:expected_answer) { 11_048 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input2)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 45 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2 other' do
      let(:expected_answer) { 64 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input2)).to eq(expected_answer)
      end
    end
  end
end
