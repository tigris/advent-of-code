# frozen_string_literal: true

# Advent of Code puzzle
class CO2ScrubberRating
  class << self
    # rubocop:disable Metrics/AbcSize
    def call(input)
      pattern = ''

      input[0].length.times do |i|
        matched = input.select { |x| x.start_with?(pattern) }
        pattern += matched.map { |x| x[i].to_i }.sum < (matched.length / 2.0) ? '1' : '0'
        matched = matched.select { |x| x.start_with?(pattern) }
        return matched[0].to_i(2) if matched.size == 1
      end
    end
    # rubocop:enable Metrics/AbcSize
  end
end
