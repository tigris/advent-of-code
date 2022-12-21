# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      {
        root: %i[pppw + sjmn],
        dbpl: 5,
        cczh: %i[sllz + lgvd],
        zczc: 2,
        ptdq: %i[humn - dvpt],
        dvpt: 3,
        lfqf: 4,
        humn: 5,
        ljgn: 2,
        sjmn: %i[drzm * dbpl],
        sllz: 4,
        pppw: %i[cczh / lfqf],
        lgvd: %i[ljgn * ptdq],
        drzm: %i[hmdt - zczc],
        hmdt: 32
      }
    end

    describe '.part1' do
      let(:expected_answer) { 152 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 301 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input, 500)).to eq(expected_answer)
      end
    end
  end
end
