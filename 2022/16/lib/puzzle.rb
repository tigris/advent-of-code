# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      rates = {}
      paths = {}

      input.each do |x|
        rates[x[0]] = x[1]
        paths[x[0]] = x[2]
      end

      search = [
        {
          current: :AA,
          time_left: 30,
          should_open: false,
          opened: [],
          pressure: 0
        }
      ]

      best = search[0]
      cache = {}
      sorted_cache = {}

      until search.empty?
        option = search.shift
        best   = option if option[:pressure] > best[:pressure]

        # the list of opened can't be ordered in this cache key because perhaps
        # opening in a different order might be more beneficial
        key = [option[:current], option[:time_left], option[:should_open], option[:opened]]

        next if option[:time_left] <= 1
        next if cache[key]

        cache[key] = true

        # Bail on this search tree if with this minutes left, we already opened
        # the same valves for a better max pressure
        sorted_key = [option[:current], option[:time_left], option[:should_open], option[:opened].sort]
        next if sorted_cache[sorted_key] && sorted_cache[sorted_key] > option[:pressure]

        sorted_cache[sorted_key] = option[:pressure]

        if option[:should_open] && !option[:opened].include?(option[:current]) && option[:time_left] > 1
          option[:time_left] -= 1
          option[:opened] = option[:opened] + [option[:current]]
          option[:pressure] = option[:pressure] + (rates[option[:current]] * option[:time_left])
        end

        paths[option[:current]].each do |tunnel|
          try = {
            current: tunnel,
            time_left: option[:time_left] - 1,
            opened: option[:opened].dup,
            pressure: option[:pressure]
          }
          search << try.merge(should_open: true) unless rates[tunnel].zero? || try[:opened].include?(tunnel)
          search << try.merge(should_open: false)
        end
      end

      # puts best.inspect
      best[:pressure]
    end

    def part2(input)
      rates = {}
      paths = {}

      input.each do |x|
        rates[x[0]] = x[1]
        paths[x[0]] = x[2]
      end
      num_valves = rates.values.select(&:positive?).size

      search = [{
        opened: {},
        pressure: 0,
        time_left: 26,
        me: { current: :AA, should_open: false },
        elephant: { current: :AA, should_open: false }
      }]

      best = search[0]
      cache = {}

      until search.empty?
        option = search.shift
        best   = option if option[:pressure] > best[:pressure]
        key    = [
          option[:me],
          option[:elephant],
          option[:time_left],
          option[:opened]
        ]

        if option[:opened].size == num_valves
          puts key.inspect
          next
        end
        if option[:time_left] <= 1
          puts key.inspect
          next
        end
        if cache[key]
          # puts key.inspect
          next
        end

        cache[key] = true

        moving = :both
        if option[:me][:should_open] && !option[:opened][option[:me][:current]]
          if option[:elephant][:should_open] && !option[:opened][option[:elephant][:current]] && option[:me][:current] != option[:elephant][:current]
            # BOTH OPENING!
            option[:time_left] -= 1
            option[:opened] = option[:opened].merge({ option[:me][:current] => :me, option[:elephant][:current] => :elephant })
            option[:pressure] = option[:pressure] + (rates[option[:me][:current]] * option[:time_left]) + (rates[option[:elephant][:current]] * option[:time_left])
          else
            # ONLY ME OPENING
            option[:opened] = option[:opened].merge(option[:me][:current] => :me)
            option[:pressure] = option[:pressure] + (rates[option[:me][:current]] * (option[:time_left] - 1))
            moving = :elephant
          end
        elsif option[:elephant][:should_open] && !option[:opened][option[:elephant][:current]]
          # ONLY ELEPHANT OPENING
          option[:opened] = option[:opened].merge(option[:elephant][:current] => :elephant)
          option[:pressure] = option[:pressure] + (rates[option[:elephant][:current]] * (option[:time_left] - 1))
          moving = :me
        end

        try = {
          time_left: option[:time_left] - 1,
          opened: option[:opened],
          pressure: option[:pressure]
        }

        case moving
        when :both
          paths[option[:me][:current]].each do |tunnel_a|
            me_can_open = (rates[tunnel_a]).positive? && !try[:opened][tunnel_a]

            paths[option[:elephant][:current]].each do |tunnel_b|
              elephant_can_open = (rates[tunnel_b]).positive? && !try[:opened][tunnel_b]

              if me_can_open && elephant_can_open
                search << try.merge({
                                      me: { current: tunnel_a, should_open: true },
                                      elephant: { current: tunnel_b, should_open: true }
                                    })
              end

              if me_can_open
                search << try.merge({
                                      me: { current: tunnel_a, should_open: true },
                                      elephant: { current: tunnel_b, should_open: false }
                                    })
              end

              if elephant_can_open
                search << try.merge({
                                      me: { current: tunnel_a, should_open: false },
                                      elephant: { current: tunnel_b, should_open: true }
                                    })
              end

              search << try.merge({
                                    me: { current: tunnel_a, should_open: false },
                                    elephant: { current: tunnel_b, should_open: false }
                                  })
            end
          end
        when :me
          paths[option[:me][:current]].each do |tunnel_a|
            tunnel_b = option[:elephant][:current]
            me_can_open = (rates[tunnel_a]).positive? && !try[:opened][tunnel_a]

            if me_can_open
              search << try.merge({
                                    me: { current: tunnel_a, should_open: true },
                                    elephant: { current: tunnel_b, should_open: false }
                                  })
            end

            search << try.merge({
                                  me: { current: tunnel_a, should_open: false },
                                  elephant: { current: tunnel_b, should_open: false }
                                })
          end
        when :elephant
          paths[option[:elephant][:current]].each do |tunnel_b|
            tunnel_a = option[:me][:current]
            elephant_can_open = (rates[tunnel_b]).positive? && !try[:opened][tunnel_b]

            if elephant_can_open
              search << try.merge({
                                    me: { current: tunnel_a, should_open: false },
                                    elephant: { current: tunnel_b, should_open: true }
                                  })
            end

            search << try.merge({
                                  me: { current: tunnel_a, should_open: false },
                                  elephant: { current: tunnel_b, should_open: false }
                                })
          end
        end
      end

      puts best.inspect
      best[:pressure]
    end
  end
end
