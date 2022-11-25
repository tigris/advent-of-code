# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        ['forward', 5],
        ['down', 5],
        ['forward', 8],
        ['up', 3],
        ['down', 8],
        ['forward', 2]
      ]
    end
    let(:expected_answer) { 900 }

    describe '.call' do
      it 'returns the correct result' do
        expect(described_class.call(provided_input)).to eq(expected_answer)
      end
    end
  end
end
