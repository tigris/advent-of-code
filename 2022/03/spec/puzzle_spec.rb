# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      %w[
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 157 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 70 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
