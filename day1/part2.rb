NUMBER_WORDS = %w(one two three four five six seven eight nine).zip("1".."9")
REVERSE_NUMBER_WORDS = NUMBER_WORDS.map { |word, number| [word.reverse, number] }

def first_number(line, number_words=NUMBER_WORDS)
  if ('0'..'9').include?(line.chars[0])
    return line.chars[0]
  end
  number_words.each do |word, number|
    return number if line.start_with?(word)
  end
  return first_number(line[1..], number_words)
end

def last_number(line)
  first_number(line.reverse, REVERSE_NUMBER_WORDS)
end

def calibration_value(line)
  (first_number(line) + last_number(line)).to_i
end

def main
  strings = File.foreach('./input.txt').map(&:chomp)
  values = strings.map { |line| calibration_value(line) }
  puts values.sum
end

main if __FILE__ == $PROGRAM_NAME
