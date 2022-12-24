# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        [:AA, 0, %i[DD II BB]],
        [:BB, 13, %i[CC AA]],
        [:CC, 2, %i[DD BB]],
        [:DD, 20, %i[CC AA EE]],
        [:EE, 3, %i[FF DD]],
        [:FF, 0, %i[EE GG]],
        [:GG, 0, %i[FF HH]],
        [:HH, 22, [:GG]],
        [:II, 0, %i[AA JJ]],
        [:JJ, 21, [:II]]
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 1651 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    # describe '.part2' do
    #   let(:expected_answer) { 1707 }
    #
    #   it 'returns the correct result' do
    #     expect(described_class.part2(provided_input)).to eq(expected_answer)
    #   end
    # end
  end
end
