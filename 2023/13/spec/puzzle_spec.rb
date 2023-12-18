# frozen_string_literal: true

require 'puzzle'

RSpec.describe Puzzle do
  context 'with provided examples' do
    let(:provided_input) do
      [
        '#.##..##.',
        '..#.##.#.',
        '##......#',
        '##......#',
        '..#.##.#.',
        '..##..##.',
        '#.#.##.#.',
        '',
        '#...##..#',
        '#....#..#',
        '..##..###',
        '#####.##.',
        '#####.##.',
        '..##..###',
        '#....#..#'
      ]
    end

    describe '.part1' do
      let(:expected_answer) { 405 }

      it 'returns the correct result' do
        expect(described_class.part1(provided_input)).to eq(expected_answer)
      end
    end

    describe '.part2' do
      let(:expected_answer) { 400 }

      it 'returns the correct result' do
        expect(described_class.part2(provided_input)).to eq(expected_answer)
      end
    end

    describe '.mirrored_left' do
      let(:image) {
        [
          '#.##..##.',
          '..#.##.#.',
          '##......#',
          '##......#',
          '..#.##.#.',
          '..##..##.',
          '#.#.##.#.'
        ]
      }

      it 'works' do
        expect(described_class.mirrored_left(image, 0)).to eq(5)
      end

      context 'when not mirrored' do
        let(:image) {
          [
            '#...##..#',
            '#....#..#',
            '..##..###',
            '#####.##.',
            '#####.##.',
            '..##..###',
            '#....#..#'
          ]
        }

        it 'works' do
          expect(described_class.mirrored_left(image, 0)).to eq(0)
        end
      end
    end

    describe '.mirrored_above' do
      let(:image) {
        [
          '#...##..#',
          '#....#..#',
          '..##..###',
          '#####.##.',
          '#####.##.',
          '..##..###',
          '#....#..#'
        ]
      }

      it 'works' do
        expect(described_class.mirrored_above(image, 0)).to eq(4)
      end

      context 'allowed diff is 1' do
        let(:image) do
          [
            '#.##..##.',
            '..#.##.#.',
            '##......#',
            '##......#',
            '..#.##.#.',
            '..##..##.',
            '#.#.##.#.'
          ]
        end

        it 'works' do
          expect(described_class.mirrored_above(image, 1)).to eq(3)
        end
      end
    end
  end
end
