# frozen_string_literal: true

require 'puzzle/helpers'

RSpec.describe Puzzle::Helpers do
  describe '#range_compact' do
    it 'works when ranges have no gap' do
      expect(described_class.range_compact([3..5, 4..8])).to eq([3..8])
    end

    it 'works when there is a gap' do
      input = [3..5, 100..110]
      expect(described_class.range_compact(input)).to eq(input)
    end

    it 'works when the edges match' do
      expect(described_class.range_compact([1..3, 3..5])).to eq([1..5])
    end
  end

  describe '#range_union' do
    it 'returns nil when there is no overlap' do
      expect(described_class.range_union(1..3, 4..5)).to be_nil
    end

    it 'unions when there is overlap' do
      expect(described_class.range_union(1..3, 2..4)).to eq(1..4)
    end

    it 'unions when the edges match' do
      expect(described_class.range_union(1..3, 3..4)).to eq(1..4)
    end
  end
end
