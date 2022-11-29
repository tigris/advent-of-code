# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      []
    end
    let(:expected_answer) { nil }

    describe '.call' do
      it 'returns the correct result' do
        expect(described_class.call(provided_input)).to eq(expected_answer)
      end
    end
  end
end
