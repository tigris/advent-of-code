# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) { [3, 4, 3, 1, 2] }
    let(:expected_answer) { 5934 }
    let(:days) { 80 }

    describe '.call' do
      it 'returns the correct result' do
        expect(described_class.call(provided_input, days)).to eq(expected_answer)
      end

      it 'works on shorter days too' do
        expect(described_class.call(provided_input, 18)).to eq(26)
      end

      it 'works on longer days' do
        expect(described_class.call(provided_input, 256)).to eq(26_984_457_539)
      end
    end
  end
end
