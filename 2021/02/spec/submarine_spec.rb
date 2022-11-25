# frozen_string_literal: true

require 'submarine'

RSpec.describe Submarine do
  subject(:submarine) { described_class.new }

  describe '.new' do
    it 'defaults to horizontal 0' do
      expect(submarine.horizontal).to eq(0)
    end

    it 'defaults to depth 0' do
      expect(submarine.depth).to eq(0)
    end

    it 'defaults to aim 0' do
      expect(submarine.aim).to eq(0)
    end
  end

  describe '.forward' do
    it 'moves forward' do
      submarine.forward(1)
      expect(submarine.horizontal).to eq(1)
    end

    it 'increases depth when aim set' do
      submarine.down(2)
      submarine.forward(2)
      expect(submarine.depth).to eq(4)
    end

    it 'does not increase depth if aim 0' do
      submarine.forward(2)
      expect(submarine.depth).to eq(0)
    end
  end

  describe '.down' do
    it 'aims down' do
      submarine.down(1)
      expect(submarine.aim).to eq(1)
    end
  end

  describe '.up' do
    it 'aims up' do
      submarine.down(5)
      submarine.up(1)
      expect(submarine.aim).to eq(4)
    end
  end
end
