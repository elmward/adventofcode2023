def almanac_map(source, map)
  map.entries.each do |source_range, offset|
    return source + offset if source_range.include?(source)
  end
  source
end

def parse_almanac(input)
  {}.tap do |almanac|
    input.split("\n\n").each do |chunk|
      if chunk.start_with?("seeds: ")
        almanac["seeds"] = chunk.split[1..].map(&:to_i)
      else
        lines = chunk.split("\n")
        map_name = lines[0].split.first
        almanac[map_name] = parse_maps(lines[1..])
      end
    end
  end
end

def parse_maps(map_strings)
  {}.tap do |output_hash|
    map_strings.each do |map_string|
      dest, source, length = map_string.split.map(&:to_i)
      output_hash[(source..(source + length - 1))] = dest - source
    end
  end
end

def main
  almanac = parse_almanac(File.open("./input.txt").read)
  locations = almanac["seeds"].map do |seed|
    soil = almanac_map(seed, almanac["seed-to-soil"])
    fertilizer = almanac_map(soil, almanac["soil-to-fertilizer"])
    water = almanac_map(fertilizer, almanac["fertilizer-to-water"])
    light = almanac_map(water, almanac["water-to-light"])
    temperature = almanac_map(light, almanac["light-to-temperature"])
    humidity = almanac_map(temperature, almanac["temperature-to-humidity"])
    location = almanac_map(humidity, almanac["humidity-to-location"])
  end
  puts locations.min
end

main if __FILE__ == $PROGRAM_NAME
