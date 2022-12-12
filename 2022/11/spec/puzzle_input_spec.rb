# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        [
          'Monkey 0:',
          '  Starting items: 79, 98',
          '  Operation: new = old * 19',
          '  Test: divisible by 23',
          '    If true: throw to monkey 2',
          '    If false: throw to monkey 3'
        ].join("\n"),
        [
          'Monkey 1:',
          '  Starting items: 54, 65, 75, 74',
          '  Operation: new = old + 6',
          '  Test: divisible by 19',
          '    If true: throw to monkey 2',
          '    If false: throw to monkey 0'
        ].join("\n"),
        [
          'Monkey 2:',
          '  Starting items: 79, 60, 97',
          '  Operation: new = old * old',
          '  Test: divisible by 13',
          '    If true: throw to monkey 1',
          '    If false: throw to monkey 3'
        ].join("\n"),
        [
          'Monkey 3:',
          '  Starting items: 74',
          '  Operation: new = old + 3',
          '  Test: divisible by 17',
          '    If true: throw to monkey 0',
          '    If false: throw to monkey 1'
        ].join("\n")
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
