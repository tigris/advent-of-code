# frozen_string_literal: true

require 'fish'

RSpec.describe Fish do
  describe '.timer' do
    it 'defaults to 8' do
      expect(described_class.new.timer).to eq(8)
    end

    it 'can be set' do
      expect(described_class.new(3).timer).to eq(3)
    end
  end

  describe '.reduce!' do
    subject(:fish) { described_class.new(timer) }

    let(:timer) { 4 }

    it 'reduces the time' do
      fish.reduce!
      expect(fish.timer).to eq(timer - 1)
    end

    it 'returns nil if timer has more to go' do
      expect(fish.reduce!).to be_nil
    end

    context 'when reduced below zero' do
      let(:timer) { 0 }

      it 'returns a new fish if reduced to zero' do
        expect(fish.reduce!).to be_a(described_class)
      end

      it 'returns a new fish with correct timer' do
        expect(fish.reduce!&.timer).to eq(8)
      end

      it 'resets the timer when reduced to zero' do
        fish.reduce!
        expect(fish.timer).to eq(6)
      end
    end
  end
end
