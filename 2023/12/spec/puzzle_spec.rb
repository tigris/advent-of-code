# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        '???.### 1,1,3',
        '.??..??...?##. 1,1,3',
        '?#?#?#?#?#?#?#? 1,3,1,6',
        '????.#...#... 4,1,1',
        '????.######..#####. 1,6,5',
        '?###???????? 3,2,1'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 21 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 525_152 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end

  describe '.arrangements' do
    it 'works for simple input' do
      # expect(described_class.arrangements('#.'.chars, [1])).to eq(1)
      # expect(described_class.arrangements('#.'.chars, [1])).to eq(1)
      # expect(described_class.arrangements('#..'.chars, [1])).to eq(1)
      # expect(described_class.arrangements('.#.'.chars, [1])).to eq(1)
      # expect(described_class.arrangements('.?.'.chars, [1])).to eq(1)
      # expect(described_class.arrangements('?#.'.chars, [2])).to eq(1)
      # expect(described_class.arrangements('???.###.'.chars, [1,1,3])).to eq(1)
      # expect(described_class.arrangements('.??..??...?##..'.chars, [1,1,3])).to eq(4)
      # expect(described_class.arrangements('?#?#?#?#?#?#?#?.'.chars, [1,3,1,6])).to eq(1)
      # expect(described_class.arrangements('????.#...#....'.chars, [4,1,1])).to eq(1)
      # expect(described_class.arrangements('????.######..#####..'.chars, [1,6,5])).to eq(4)
      expect(described_class.arrangements('?###????????.'.chars, [3, 2, 1])).to eq(10)
    end
  end
end
