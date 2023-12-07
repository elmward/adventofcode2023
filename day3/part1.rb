def adjacent?(char_pos, string_pos, length)
  (string_pos[0] - char_pos[0]).abs <= 1 &&
  (char_pos[1] - string_pos[1]) >= -1 &&
  (char_pos[1] - string_pos[1]) <= length
end

def part_number?(position, diagram)
  number = diagram[:numbers][position]
  number_length = number.digits.length
  val = diagram[:symbols].any? do |symbol_position, _|
    adjacent?(symbol_position, position, number_length)
  end
  val
end

def parse_diagram(input)
  diagram = {
    numbers: {},
    symbols: {}
  }

  input.split("\n").each.with_index do |line, y|
    x = 0
    while x < line.chars.length
      current_char = line.chars[x]
      if current_char == '.'
        x += 1
      elsif !('0'..'9').include?(current_char)
        diagram[:symbols][[y,x]] = current_char
        x += 1
      else
        number = ''
        while ('0'..'9').include?(current_char)
          number << current_char
          x += 1
          current_char = line[x]
        end
        diagram[:numbers][[y, x-number.chars.length]] = number.to_i
      end
    end
  end
  diagram
end

def main
  diagram = parse_diagram(File.open('./input.txt').read)
  puts diagram[:numbers].entries.map { |position, number| part_number?(position, diagram) ? number : 0 }.sum
end

main if __FILE__ == $PROGRAM_NAME
