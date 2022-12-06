# frozen_string_literal: true

# Advent of Code puzzle
class Puzzle
  class << self
    def part1(input)
      caves = {}.tap { |h| input.flatten.uniq.each { |x| h[x] = [] } }

      input.each do |start, finish|
        caves[start] << finish
        caves[finish] << start
      end

      routes = []
      paths = [['start']]
      until paths.empty?
        path = paths.pop

        next if path.last == 'end' && routes.append(path)

        caves[path.last].each do |cave|
          paths.append([*path, cave]) unless cave =~ /^[a-z]+$/ && path.include?(cave)
        end
      end

      routes.size
    end

    def part2(input)
      caves = {}.tap { |h| input.flatten.uniq.each { |x| h[x] = [] } }

      input.each do |start, finish|
        caves[start] << finish
        caves[finish] << start
      end

      routes = []
      paths = [['start']]
      until paths.empty?
        path = paths.pop

        next if path.last == 'end' && routes.append(path)

        caves[path.last].each do |cave|
          next if cave == 'start'

          if cave =~ /^[a-z]+$/
            smalls = path.grep(/^[a-z]+$/)
            dupe_smalls = smalls.size - smalls.uniq.size
            allowed = dupe_smalls.zero? ? 2 : 1

            next if path.select { |c| c == cave }.size >= allowed
          end

          paths.append([*path, cave])
        end
      end

      routes.size
    end
  end
end
