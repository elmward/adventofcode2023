def main
  strings = File.foreach('./input.txt').map(&:chomp)
  values = strings.map do |line|
    digits = line.chars.select { |c| (0..9).map(&:to_s).include?(c) }
    (digits[0] + digits[-1]).to_i
  end
  puts values.sum
end

main if __FILE__ == $PROGRAM_NAME
