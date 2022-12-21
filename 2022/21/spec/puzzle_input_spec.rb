# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
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

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
