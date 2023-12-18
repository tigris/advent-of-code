# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        'rn=1',
        'cm-',
        'qp=3',
        'cm=2',
        'qp-',
        'pc=4',
        'ot=9',
        'ab=5',
        'pc-',
        'pc=6',
        'ot=7'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 1320 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 145 }

      fit 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
