# frozen_string_literal: true

require 'oxygen_generator_rating'

RSpec.describe OxygenGeneratorRating do
  context 'with valid input' do
    describe '.call' do
      let(:input) { %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010] }

      it 'returns the correct value' do
        expect(described_class.call(input)).to eq(23)
      end
    end
  end
end
