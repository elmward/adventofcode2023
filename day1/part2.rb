NUMBER_WORDS = %w(one two three four five six seven eight nine).zip("1".."9")
REVERSE_NUMBER_WORDS = NUMBER_WORDS.map { |word, number| [word.reverse, number] }

def first_number(line, number_words=NUMBER_WORDS)
  i = 0
  while true # input guarantees a return value
    if ('0'..'9').include?(line.chars[i])
      return line.chars[i]
    end
    number_words.each do |word, number|
      return number if line[i..].start_with?(word)
    end
    i += 1
  end
end

def right_number(line)
  first_number(line.reverse, REVERSE_NUMBER_WORDS)
end

def calibration_value(line)
  (first_number(line) + right_number(line)).to_i
end

def main
  strings = File.foreach('./input.txt').map(&:chomp)
  values = strings.map { |line| calibration_value(line) }
  puts values.sum
end

main if __FILE__ == $PROGRAM_NAME
