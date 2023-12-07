# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        %w(32T3K 765),
        %w(T55J5 684),
        %w(KK677 28),
        %w(KTJJT 220),
        %w(QQQJA 483)
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 6440 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 5905 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end

RSpec.describe Hand do
  context 'when starting with a pair of jokers' do
    subject { described_class.new('jj345') }

    it 'counts as three of a kind' do
      expect(subject.three_oak?).to be_truthy
    end
  end

  context 'when five jokers' do
    subject { described_class.new('jjjjj') }

    it 'counts as five of a kind' do
      expect(subject.five_oak?).to be_truthy
    end
  end
end
