# frozen_string_literal: true

require 'puzzle_input'

RSpec.describe PuzzleInput do
  context 'with a valid file' do
    let(:filename) { File.join(__dir__, 'fixtures', 'input.txt') }
    let(:expected) do
      [
        '5483143223'.chars.map(&:to_i),
        '2745854711'.chars.map(&:to_i),
        '5264556173'.chars.map(&:to_i),
        '6141336146'.chars.map(&:to_i),
        '6357385478'.chars.map(&:to_i),
        '4167524645'.chars.map(&:to_i),
        '2176841721'.chars.map(&:to_i),
        '6882881134'.chars.map(&:to_i),
        '4846848554'.chars.map(&:to_i),
        '5283751526'.chars.map(&:to_i)
      ]
    end

    describe '.call' do
      it 'returns the correct structure' do
        expect(described_class.call(filename)).to eq(expected)
      end
    end
  end
end
