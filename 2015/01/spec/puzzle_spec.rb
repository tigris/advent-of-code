# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        '(())',
        '()()',
        '(((',
        '(()(()(',
        '))(((((',
        '())',
        '))(',
        ')))',
        ')())())'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { [0, 0, 3, 3, 3, -1, -1, -3, -3] }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { [nil, nil, nil, nil, 1, 3, 1, 1, 1] }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
