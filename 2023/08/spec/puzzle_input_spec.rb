# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      {
        'moves' => %w[R L],
        'AAA' => %w[BBB CCC],
        'BBB' => %w[DDD EEE],
        'CCC' => %w[ZZZ GGG],
        'DDD' => %w[DDD DDD],
        'EEE' => %w[EEE EEE],
        'GGG' => %w[GGG GGG],
        'ZZZ' => %w[ZZZ ZZZ]
      }
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
