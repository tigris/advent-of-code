# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
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

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
