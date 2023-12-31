# frozen_string_literal: true

require_relative 'helpers'

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input, times = 1000)
      states = {}
      connectors = {}
      called = { high: 0, low: 0 }

      modules = Hash.new lambda { |pulse, _called_by|
        # p "#{called_by} -#{pulse}-> :unknown"
        called[pulse] += 1
        [:nothing, []]
      }

      jobs = []

      input.each do |line|
        type, name, destinations = line.match(/^([%&=]?)(\w+) -> (.+)$/).captures
        destinations = destinations.split(', ')

        # initial states
        states[name] = type == '&' ? Hash.new(:low) : :off
        destinations.each do |d|
          connectors[d] ||= []
          connectors[d] << name
        end

        modules[name] = lambda { |pulse, called_by|
          # p "#{called_by} -#{pulse}-> #{name}"
          called[pulse] += 1
          case type
          when ''
            [states[name], destinations.map { |d| [d, :low, name] }]
          when '%'
            return [states[name], []] if pulse == :high

            if states[name] == :off
              [:on, destinations.map { |d| [d, :high, name] }]
            else
              [:off, destinations.map { |d| [d, :low, name] }]
            end
          when '&'
            check_state = states[name].merge(called_by => pulse)
            if connectors[name].all? { |x| check_state[x] == :high }
              [{ called_by => pulse }, destinations.map { |d| [d, :low, name] }]
            else
              [{ called_by => pulse }, destinations.map { |d| [d, :high, name] }]
            end
          when '='
            if pulse == :high
              [states[name], []]
            else
              [called[:high] + called[:low], []]
            end
          end
        }
      end

      times.times do
        states['rx'] = :nothing

        jobs << ['broadcaster', :low, :button]
        until jobs.empty?
          job = jobs.shift

          new_state, new_jobs = modules[job[0]].call(job[1], job[2])

          jobs += new_jobs
          states[job[0]] = new_state.is_a?(Hash) ? states[job[0]].merge(new_state) : new_state
        end

        return states['rx'] if states['rx'] != :nothing
      end

      called[:low] * called[:high]
    end

    def part2(input)
      part1(input + ['=rx -> nowhere'], 1_000_000_000_000_000)
    end
  end
end
