# frozen_string_literal: true

require 'card'

RSpec.describe Card do
  subject(:card) { described_class.new(rows) }

  let(:rows) { [[1, 2, 3], [1, 2, 3], [1, 2, 3]] }
  let(:cols) { [[1, 1, 1], [2, 2, 2], [3, 3, 3]] }

  describe '.games' do
    it 'returns the expected result' do
      expect(card.games).to eq(rows + cols)
    end
  end

  describe '.remove_number' do
    it 'removes the number' do
      card.remove_number(1)
      expect(card.games[0]).to eq([2, 3])
    end

    it 'returns false when numbers still exist' do
      expect(card.remove_number(4)).to be(false)
    end

    it 'returns true if there was a winner' do
      expect(card.remove_number(2)).to be(true)
    end
  end

  describe '.sum_numbers' do
    it 'returns the expected result' do
      card.remove_number(3)
      expect(card.sum_numbers).to eq(9)
    end
  end
end
