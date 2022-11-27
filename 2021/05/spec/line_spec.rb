# frozen_string_literal: true

require 'line'

RSpec.describe Line do
  context 'with horizontal line' do
    subject(:line) { described_class.new(Vector[0, 3], Vector[3, 3]) }

    describe '.points' do
      it 'plots all the points' do
        expect(line.points).to eq([Vector[0, 3], Vector[1, 3], Vector[2, 3], Vector[3, 3]])
      end
    end

    describe '.horizontal?' do
      it 'is true' do
        expect(line.horizontal?).to be(true)
      end
    end

    describe '.vertical?' do
      it 'is false' do
        expect(line.vertical?).to be(false)
      end
    end

    describe '.diagonal?' do
      it 'is false' do
        expect(line.diagonal?).to be(false)
      end
    end
  end

  context 'with vertical line' do
    subject(:line) { described_class.new(Vector[8, 8], Vector[8, 6]) }

    describe '.points' do
      it 'plots all the points' do
        expect(line.points).to eq([Vector[8, 6], Vector[8, 7], Vector[8, 8]])
      end
    end

    describe '.horizontal?' do
      it 'is false' do
        expect(line.horizontal?).to be(false)
      end
    end

    describe '.vertical?' do
      it 'is true' do
        expect(line.vertical?).to be(true)
      end
    end

    describe '.diagonal?' do
      it 'is false' do
        expect(line.diagonal?).to be(false)
      end
    end
  end

  context 'with a diagonal line' do
    subject(:line) { described_class.new(Vector[0, 0], Vector[2, 2]) }

    describe '.points' do
      it 'plots points for forwards diagonal down' do
        expect(line.points).to include(Vector[0, 0], Vector[1, 1], Vector[2, 2])
      end

      it 'plots points for backwards diagonal up' do
        line = described_class.new(Vector[2, 2], Vector[0, 0])
        expect(line.points).to include(Vector[2, 2], Vector[1, 1], Vector[0, 0])
      end

      it 'plots points for backwards diagonal down' do
        line = described_class.new(Vector[0, 2], Vector[2, 0])
        expect(line.points).to include(Vector[0, 2], Vector[1, 1], Vector[2, 0])
      end

      it 'plots points for forwards diagonal up' do
        line = described_class.new(Vector[2, 0], Vector[0, 2])
        expect(line.points).to include(Vector[0, 2], Vector[1, 1], Vector[2, 0])
      end
    end

    describe '.horizontal?' do
      it 'is false' do
        expect(line.horizontal?).to be(false)
      end
    end

    describe '.vertical?' do
      it 'is false' do
        expect(line.vertical?).to be(false)
      end
    end

    describe '.diagonal?' do
      it 'is true' do
        expect(line.diagonal?).to be(true)
      end
    end
  end
end
