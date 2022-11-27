# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        [Vector[0, 9], Vector[5, 9]],
        [Vector[8, 0], Vector[0, 8]],
        [Vector[9, 4], Vector[3, 4]],
        [Vector[2, 2], Vector[2, 1]],
        [Vector[7, 0], Vector[7, 4]],
        [Vector[6, 4], Vector[2, 0]],
        [Vector[0, 9], Vector[2, 9]],
        [Vector[3, 4], Vector[1, 4]],
        [Vector[0, 0], Vector[8, 8]],
        [Vector[5, 5], Vector[8, 2]]
      ]
    end
    let(:expected_answer) { 5 }

    describe '.call' do
      it 'returns the correct result' do
        expect(described_class.call(provided_input)).to eq(expected_answer)
      end
    end
  end
end
