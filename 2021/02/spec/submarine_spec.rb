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
  end

  describe '.forward' do
    it 'moves forward' do
      submarine.forward(1)
      expect(submarine.horizontal).to eq(1)
    end
  end

  describe '.down' do
    it 'moves down' do
      submarine.down(1)
      expect(submarine.depth).to eq(1)
    end
  end

  describe '.up' do
    it 'moves up' do
      submarine.down(5)
      submarine.up(1)
      expect(submarine.depth).to eq(4)
    end
  end
end
