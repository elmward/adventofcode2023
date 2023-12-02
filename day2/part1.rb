NUM_RED = 12
NUM_GREEN = 13
NUM_BLUE = 14

def count_cubes(cubes_pulled)
  Hash.new { 0 }.tap do |colors_to_counts|
    num_colors = cubes_pulled.split(', ')
    num_colors.each do |num_color|
      num, color = num_color.split
      colors_to_counts[color] = num.to_i
    end
  end
end

def main
  possible_games_sum = 0
  lines = File.open('./input.txt').readlines.map(&:chomp)
  lines.each do |line|
    game, pulls = line.split(': ')
    game_number = game.split(' ')[1].to_i
    possible_games_sum += game_number if pulls.split('; ').all? do |pull|
      cube_counts = count_cubes(pull)
      cube_counts["red"] <= NUM_RED && cube_counts["green"] <= NUM_GREEN && cube_counts["blue"] <= NUM_BLUE
    end
  end
  puts possible_games_sum
end

main if __FILE__ == $PROGRAM_NAME
