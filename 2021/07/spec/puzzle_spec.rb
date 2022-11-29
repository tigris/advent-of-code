# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) { [16, 1, 2, 0, 4, 2, 7, 1, 2, 14] }
    let(:expected_answer) { 168 }

    describe '.call' do
      it 'returns the correct result' do
        expect(described_class.call(provided_input)).to eq(expected_answer)
      end
    end
  end
end
