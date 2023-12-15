def parse_almanac(input)
  {}.tap do |almanac|
    input.split("\n\n").each do |chunk|
      if chunk.start_with?("seeds: ")
        seed_lengths = chunk.split[1..].map(&:to_i).each_slice(2)
        seed_ranges = seed_lengths.map do |seed_length|
          last_seed_number = seed_length[0] + seed_length[1] - 1
          seed_length[0]..last_seed_number
        end
        almanac["seeds"] = seed_ranges
      else
        lines = chunk.split("\n")
        map_name = lines[0].split.first
        almanac[map_name] = parse_maps(lines[1..])
      end
    end
  end
end

# could try iterating over maps
# problem is we have to maintain a set of destinations
# to return and it updates constantly, the sources also change
# as destinations are mapped from the sources, AND
# you've got to be sure to keep passing the unmapped sources along
# so they'll get checked at each step and returned as mapped at the end
# (that last part maybe isn't so bad)
# sources definitely needs to be an array of ranges to check, and it
# needs to change as we go. But maybe that's not so bad -- we won't
# be changing the thing we're iterating over (maps)
# can pop/push sources to mutate it
def map_sources(source_ranges, maps)
  destinations = []
  last_map_index = maps.keys.length - 1
  maps.each.with_index do |map, i|
    matches, offset = map[0], map[1]
    # puts "Target map is #{matches} with offset #{offset}"
    original_source_ranges = source_ranges.clone
    # FIXME: this isn't going to be right because we want to map the splits that didn't get offset
    original_source_ranges.each do |sources|
      # puts "Mapping #{sources}"
      if matches.last < sources.first || matches.first > sources.last
        # no overlap
        # puts "no overlap with #{matches}"
        if i == last_map_index
          destinations << sources
        end
      elsif sources.first == matches.first
        # shared left boundary (1..4, 1..9) => (1..4, 5..9)
        # puts "shared left boundary with #{matches}"
        matching_range = [sources, matches].min_by { |r| r.last }
        destinations << ((matching_range.first + offset)..(matching_range.last + offset))
      elsif sources.last == matches.last
        # shared right boundary (4..9, 1..9) => (1..3, 4..9)
        # puts "shared right boundary with #{matches}"
        matching_range = [sources, matches].max_by { |r| r.first }
        destinations << ((matching_range.first + offset)..(matching_range.last + offset))
      elsif sources.cover?(matches)
        # return sources before, offset in match, sources after
        # puts "source range fully contains #{matches}"
        source_ranges.push(sources.first..(matches.first - 1))
        source_ranges.delete(matches.first..matches.last)
        destinations << ((matches.first + offset)..(matches.last + offset))
        source_ranges.push((matches.last + 1)..sources.last)
      elsif matches.cover?(sources)
        # return just overlap plus offset
        # puts "source range fully contained by #{matches}"
        source_ranges.push(matches.first..(sources.first - 1))
        source_ranges.delete(sources.first..sources.last)
        destinations << ((sources.first + offset)..(sources.last + offset))
        source_ranges.push((sources.last + 1)..matches.last)
      elsif sources.first > matches.first && sources.last > matches.last
        # partial overlap 1
        #    sources
        # matches
        # puts "front of sources partially overlaps with #{matches}"
        destinations << ((sources.first + offset)..(matches.last + offset))
        source_ranges.delete(sources)
        if matches.last + 1 < sources.last
          source_ranges.push((matches.last + 1)..sources.last)
        end
      elsif sources.first < matches.first && sources.last < matches.last
        # partial overlap 2
        # sources
        #    matches
        # puts "end of sources partially overlaps with #{matches}"
        destinations << ((matches.first + offset)..(sources.last + offset))
        source_ranges.delete(sources)
        if sources.first < matches.first
          source_ranges.push(sources.first..matches.first - 1)
        end
      end
      # puts "found destinations #{destinations.inspect}"
      # puts "current source ranges: #{source_ranges}"
    end
  end
  destinations.uniq
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
  seeds = almanac["seeds"]
  puts "mapping soil"
  soil = map_sources(seeds, almanac["seed-to-soil"])
  puts "mapping fertilizer"
  fertilizer = map_sources(soil, almanac["soil-to-fertilizer"])
  puts "mapping water"
  water = map_sources(fertilizer, almanac["fertilizer-to-water"])
  puts "mapping light"
  light = map_sources(water, almanac["water-to-light"])
  puts "mapping temperature"
  temperature = map_sources(light, almanac["light-to-temperature"])
  puts "mapping humidity"
  humidity = map_sources(temperature, almanac["temperature-to-humidity"])
  puts "mapping location"
  location = map_sources(humidity, almanac["humidity-to-location"])
  puts location.min_by { |loc| loc.first }.first
end

main if __FILE__ == $PROGRAM_NAME
