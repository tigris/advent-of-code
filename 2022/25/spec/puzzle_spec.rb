# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  describe Puzzle::Snafu do
    describe '.to_decimal' do
      context 'with single digits' do
        let(:examples) do
          [
            [1, '1'],
            [2, '2'],
            [3, '1='],
            [4, '1-'],
            [5, '10'],
            [6, '11'],
            [7, '12'],
            [8, '2='],
            [9, '2-']
          ]
        end

        it 'converts correctly' do
          examples.each { |decimal, snafu| expect(described_class.to_decimal(snafu)).to eq(decimal) }
        end
      end

      context 'with double digits' do
        let(:examples) do
          [
            [10, '20'],
            [15, '1=0'],
            [20, '1-0']
          ]
        end

        it 'converts correctly' do
          examples.each { |decimal, snafu| expect(described_class.to_decimal(snafu)).to eq(decimal) }
        end
      end

      context 'with large numbers' do
        let(:examples) do
          [
            [2022, '1=11-2'],
            [12_345, '1-0---0'],
            [314_159_265, '1121-1110-1=0']
          ]
        end

        it 'converts correctly' do
          examples.each { |decimal, snafu| expect(described_class.to_decimal(snafu)).to eq(decimal) }
        end
      end
    end
  end

  describe Puzzle::Decimal do
    describe '.to_snafu' do
      context 'with single digits' do
        let(:examples) do
          [
            [1, '1'],
            [2, '2'],
            [3, '1='],
            [4, '1-'],
            [5, '10'],
            [6, '11'],
            [7, '12'],
            [8, '2='],
            [9, '2-']
          ]
        end

        it 'converts correctly' do
          examples.each { |decimal, snafu| expect(described_class.to_snafu(decimal)).to eq(snafu) }
        end
      end

      context 'with double digits' do
        let(:examples) do
          [
            [10, '20'],
            [15, '1=0'],
            [20, '1-0']
          ]
        end

        it 'converts correctly' do
          examples.each { |decimal, snafu| expect(described_class.to_snafu(decimal)).to eq(snafu) }
        end
      end

      context 'with large numbers' do
        let(:examples) do
          [
            [2022, '1=11-2'],
            [12_345, '1-0---0'],
            [314_159_265, '1121-1110-1=0']
          ]
        end

        it 'converts correctly' do
          examples.each { |decimal, snafu| expect(described_class.to_snafu(decimal)).to eq(snafu) }
        end
      end
    end
  end

  context 'with provided examples' do
    let(:provided_input) do
      [
        '1=-0-2',
        '12111',
        '2=0=',
        '21',
        '2=01',
        '111',
        '20012',
        '112',
        '1=-1=',
        '1-12',
        '12',
        '1=',
        '122'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { '2=-1=0' }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { nil }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end
  end
end
