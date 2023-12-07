def parse_card(input_string)
  matches = input_string.match(/^Card\s+\d+: (?<winning_numbers>[\d ]+) \| (?<played_numbers>[\d ]+)$/)
  [matches[:winning_numbers].split.map(&:to_i), matches[:played_numbers].split.map(&:to_i)]
end

def score(winning_numbers, played_numbers)
  matches = played_numbers.count { |num| winning_numbers.include?(num) }
  if matches == 0
    0
  else
    2 ** (matches - 1)
  end
end

def main
  puts(File.open('./input.txt').readlines.sum { |line| score(*parse_card(line.chomp)) })
end

main if __FILE__ == $PROGRAM_NAME
