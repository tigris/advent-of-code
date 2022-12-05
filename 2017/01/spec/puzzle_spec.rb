# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      ['91212129'.chars.map(&:to_i)]
    end

    describe '.part1' do
      let(:expected_answer) { 9 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end

      it 'returns the correct result 2' do
        expect(described_class.part1(['1122'.chars.map(&:to_i)])).to eq(3)
      end
    end

    describe '.part2' do
      let(:provided_input) do
        ['123425'.chars.map(&:to_i)]
      end
      let(:expected_answer) { 4 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
