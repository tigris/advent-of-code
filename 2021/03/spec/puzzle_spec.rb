# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) { %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010] }
    let(:expected_answer) { 230 }

    describe '.call' do
      it 'returns the correct result' do
        expect(described_class.call(provided_input)).to eq(expected_answer)
      end
    end
  end
end
