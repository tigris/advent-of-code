# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      workflows, part_ratings = input.chunk_while{|x| !x.empty? }.to_a
      workflows.pop # chunk_while pulls in the delimiter

      # Parse the ratings into a hash like { "x" => (10..10), "m" => ... }
      part_ratings = part_ratings.map do |line|
        {}.tap do |x|
          line.gsub(/[{}]/, '').split(/,/).each do |pair|
            category, rating = pair.split(/=/)
            x[category] = (rating.to_i..rating.to_i)
          end
        end
      end

      # Get all accepted parts
      accepted = accepted_parts(workflows, part_ratings)

      # The part1 answer is the sum of all x/m/a/s values in all accepted parts
      #   - using :begin on each value here because we "forced" our single value into a range in the above parsing block
      accepted.map{|p| p.values.map(&:begin).sum }.sum
    end

    def part2(input)
      workflows, _ = input.chunk_while{|x| !x.empty? }.to_a
      workflows.pop # chunk_while pulls in the delimiter

      # For part2 we're throwing away the ratings from the input and using this
      # single value of ranges
      part_ratings = [
        { 'x' => (1..4000), 'm' => (1..4000), 'a' => (1..4000), 's' => (1..4000) }
      ]

      # Get all accepted parts
      accepted = accepted_parts(workflows, part_ratings)

      # For each accepted part there will be a range for each x/m/a/s category.
      # We need to multiply the range sizes in each option to get the total
      # possible combinations, then add them all up.
      accepted.map{|p| p.values.map(&:size).reduce(:*) }.sum
    end

    # parses "in{s<1351:px,qqz}" to
    #   [
    #     "in",
    #     [
    #       { category: "s", operator: "<", threshold: 1351, method: "px" },
    #       { method: "qqz" }
    #     ]
    #   ]
    def parse_workflow(workflow)
      name, *rules_list = workflow.split(/[{,}]/)

      rules = rules_list.map do |rule|
        components = rule.split(/([<>:])/)
        if components.length == 1
          { method: components[0] }
        else
          { category: components[0], operator: components[1], threshold: components[2].to_i, method: components[4] }
        end
      end

      [name, rules]
    end

    def accepted_parts(workflows, part_ratings)
      accepted = []

      # We have 2 known exit functions, these will store the part accordingly,
      # then return the empty array meaning there is nothing more to search for
      # this "path".
      workflow_lambdas = {
        "A" => ->(part) { accepted << part ; [] },
        "R" => ->(part) { [] }
      }

      workflows.each do |workflow|
        name, rules = parse_workflow(workflow)

        # Define the lambda/proc. The interface is that it takes a hash that has
        # a x/m/a/s key where the value is a range. The return value will be an
        # array of new hashes with ranges and a method to progress to.
        workflow_lambdas[name] = ->(part) do
          rules.each do |rule|
            if rule[:threshold]
              rating = part[ rule[:category] ] # Pull the rating for this rules category out of the part hash

              # Cover cases where the range is completely out or completely in the threshold
              case rule[:operator]
              when "<"
                next if rating.min >= rule[:threshold] # Failed cos min is over and we need anything under
                return [part.dup.merge('method' => rule[:method])] if rating.max < rule[:threshold] # Passed cos max is under

                before = (rating.min .. (rule[:threshold] - 1)) # before (minus the threshold itself) should match on next run
                after = (rule[:threshold] .. rating.max) # everything after, including threshold itself, might match some other rule
              when ">"
                next if rating.max <= rule[:threshold] # Failed cos max is under and we need anything over
                return [part.dup.merge('method' => rule[:method])] if rating.min > rule[:threshold] # Passed cos min is over

                before = (rating.min .. rule[:threshold]) # everything before, including threshold itself, might match some other rule
                after = ((rule[:threshold] + 1) .. rating.max) # after (minus the threshold itself) should match on next run
              end


              return [
                part.dup.merge(rule[:category] => before),
                part.dup.merge(rule[:category] => after)
              ]
            else
              # We've hit the default clause, nothing to test, just process forward
              return [part.dup.merge('method' => rule[:method])]
            end
          end
        end
      end

      # Ok, time to search path this. We start with all the ratings we're given
      search = part_ratings
      while !search.empty?
        part = search.shift
        method = part['method'] || 'in' # If there's no method, we call "in" first
        search += workflow_lambdas[method].call(part) # Process the lambda and get back the new instructions
      end

      # Don't return the "method" value, which is obviously "A"
      accepted.map{|x| x.slice(*%w(x m a s)) }
    end
  end
end
