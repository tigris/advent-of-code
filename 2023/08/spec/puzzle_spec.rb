# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided example 1' do
    let(:provided_input) do
      {
        'moves' => %w[R L],
        'AAA' => %w[BBB CCC],
        'BBB' => %w[DDD EEE],
        'CCC' => %w[ZZZ GGG],
        'DDD' => %w[DDD DDD],
        'EEE' => %w[EEE EEE],
        'GGG' => %w[GGG GGG],
        'ZZZ' => %w[ZZZ ZZZ]
      }
    end

    describe '.part1' do
      let(:expected_answer) { 2 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end
  end

  context 'with provided example 2' do
    let(:provided_input) do
      {
        'moves' => %w[L L R],
        'AAA' => %w[BBB BBB],
        'BBB' => %w[AAA ZZZ],
        'ZZZ' => %w[ZZZ ZZZ]
      }
    end

    describe '.part1' do
      let(:expected_answer) { 6 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end
  end

  context 'with provided example 3' do
    let(:provided_input) do
      {
        'moves' => %w[L R],
        '11A' => %w[11B XXX],
        '11B' => %w[XXX 11Z],
        '11Z' => %w[11B XXX],
        '22A' => %w[22B XXX],
        '22B' => %w[22C 22C],
        '22C' => %w[22Z 22Z],
        '22Z' => %w[22B 22B],
        'XXX' => %w[XXX XXX]
      }
    end

    describe '.part2' do
      let(:expected_answer) { 6 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
