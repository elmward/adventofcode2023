NUMBER_WORDS = [
  ["one", "1"],
  ["two", "2"],
  ["three", "3"],
  ["four", "4"],
  ["five", "5"],
  ["six", "6"],
  ["seven", "7"],
  ["eight", "8"],
  ["nine", "9"]
]

REVERSE_NUMBER_WORDS = NUMBER_WORDS.map { |word, number| [word.reverse, number] }

def left_number(line, number_words=NUMBER_WORDS)
  return nil if line.empty?
  if ('0'..'9').include?(line.chars[0])
    return line.chars[0]
  end
  number_words.each do |word, number|
    return number if line.start_with?(word)
  end
  return left_number(line[1..], number_words)
end

def right_number(line)
  left_number(line.reverse, REVERSE_NUMBER_WORDS)
end

def main
  strings = File.foreach('./input.txt').map(&:chomp)
  values = strings.map do |line|
    (left_number(line) + right_number(line)).to_i
  end
  puts values.sum
end

main if __FILE__ == $PROGRAM_NAME
