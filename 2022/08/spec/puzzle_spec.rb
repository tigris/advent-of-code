# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        '30373'.chars.map(&:to_i),
        '25512'.chars.map(&:to_i),
        '65332'.chars.map(&:to_i),
        '33549'.chars.map(&:to_i),
        '35390'.chars.map(&:to_i)
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 21 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 8 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
