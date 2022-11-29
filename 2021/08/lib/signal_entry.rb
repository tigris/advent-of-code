# frozen_string_literal: true

# Advent of Code puzzle
class SignalEntry
  class << self
    def call(signals, output)
      known = {}
      signals = signals.map { |s| s.chars.sort }.uniq

      signals.each do |entry|
        case entry.length
        when 2 then known[1] = entry
        when 3 then known[7] = entry
        when 4 then known[4] = entry
        when 7 then known[8] = entry
        end
      end

      # a 3 is like a 7 but length of 5
      known[3] = signals.find { |s| s.length == 5 and known[7] - s == [] }

      # a 9 is a 4 and a 3 overlapped
      known[9] = (known[4] + known[3]).sort.uniq

      # a 0 is length 6, overlaps with a 1 but not 9
      known[0] = (signals - known.values).find { |s| s.length == 6 and known[1] - s == [] }

      # a 6 is the only other signal of length 6
      known[6] = (signals - known.values).find { |s| s.length == 6 }

      # a 5 is like a 6 but of length 5
      known[5] = signals.find { |s| s.length == 5 and s - known[6] == [] }

      # a 2 is the only remaining
      known[2] = (signals - known.values)[0]

      output.map { |o| known.key(o.chars.sort).to_s }.join.to_i
    end
  end
end
