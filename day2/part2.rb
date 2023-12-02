require_relative './part1.rb'

def max_by_keys(hashes)
  {}.tap do |max_values|
    keys = hashes.flat_map(&:keys)
    keys.each do |key|
      values = hashes.map {|h| h[key] }.compact
      max_values[key] = values.max
    end
  end
end

def main
  lines = File.open('./input.txt').readlines.map(&:chomp)
  puts(lines.sum do |line|
    _, pulls = line.split(': ')
    cube_counts = pulls.split('; ').map { |pull| count_cubes(pull) }
    max_counts = max_by_keys(cube_counts)
    max_counts["red"] * max_counts["green"] * max_counts["blue"]
  end)
end

main if __FILE__ == $PROGRAM_NAME

