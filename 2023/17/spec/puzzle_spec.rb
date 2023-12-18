# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        '2413432311323',
        '3215453535623',
        '3255245654254',
        '3446585845452',
        '4546657867536',
        '1438598798454',
        '4457876987766',
        '3637877979653',
        '4654967986887',
        '4564679986453',
        '1224686865563',
        '2546548887735',
        '4322674655533'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 102 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 94 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end

  context 'with second input' do
    let(:provided_input) do
      [
        '111111111111',
        '999999999991',
        '999999999991',
        '999999999991',
        '999999999991'
      ]
    end

    describe '.part2' do
      let(:expected_answer) { 71 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
