# frozen_string_literal: true

# Convert given file into ruby data structure
class PuzzleInput
  class << self
    def call(file)
      File.readlines(file).map(&:chomp).map do |line|
        sensor, beacon = line.split(':')
        sensor = sensor.gsub(/^Sensor at x=([-\d]+), y=([-\d]+)$/, '[\1, \2]')
        beacon = beacon.gsub(/^ closest beacon is at x=([-\d]+), y=([-\d]+)$/, '[\1, \2]')
        # rubocop:disable Security/Eval
        { sensor: eval(sensor), beacon: eval(beacon) }
        # rubocop:enable Security/Eval
      end
    end
  end
end
