require_relative './part1.rb'

def main
  gear_ratio_total = 0
  diagram = parse_diagram(File.open('./input.txt').read)
  diagram[:symbols].each do |symbol_position, _|
    adjacent_numbers = diagram[:numbers].entries.select do |number_position, number|
      adjacent?(symbol_position, number_position, number.digits.length)
    end.map(&:last)
    if adjacent_numbers.count == 2
      gear_ratio_total += adjacent_numbers.reduce(:*)
    end
  end
  puts gear_ratio_total
end

main if __FILE__ == $PROGRAM_NAME
