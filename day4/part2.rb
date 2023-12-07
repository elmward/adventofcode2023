def parse_cards(input_string)
  Hash.new.tap do |cards|
    input_string.split("\n").each do |line|
      matches = line.match(/^Card\s+(?<card_number>\d+): (?<winning_numbers>[\d ]+) \| (?<played_numbers>[\d ]+)$/)
      cards[matches[:card_number].to_i] = [matches[:winning_numbers].split.map(&:to_i), matches[:played_numbers].split.map(&:to_i)]
    end
  end
end

def num_winners(winning_numbers, played_numbers)
  played_numbers.count { |num| winning_numbers.include?(num) }
end

def card_counts(cards)
  max_card_number = cards.keys.max
  Hash.new.tap do |counts|
    (1..max_card_number).each { |num| counts[num] = 1 }
    (1..max_card_number - 1).each do |card_number|
      winning_numbers, played_numbers = cards[card_number]
      winners = num_winners(winning_numbers, played_numbers)
      last_winning_number = [card_number + winners, max_card_number].min
      ((card_number + 1)..last_winning_number).each do |num|
        counts[num] += counts[card_number]
      end
    end
  end
end

def main
  puts card_counts(parse_cards(File.open('./input.txt').read)).values.sum
end

main if __FILE__ == $PROGRAM_NAME
