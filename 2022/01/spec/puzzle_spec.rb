# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [[1000, 2000, 3000], [4000], [5000, 6000], [7000, 8000, 9000], [10_000]]
    end
    let(:expected_answer) { 45_000 }

    describe '.call' do
      it 'returns the correct result' do
        expect(described_class.call(provided_input)).to eq(expected_answer)
      end
    end
  end
end
