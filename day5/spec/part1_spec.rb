require_relative "../part1.rb"

describe "almanac_map" do
  let(:maps) do
    {
      (50..98) => 2,
      (12..24) => -3
    }
  end

  it "maps a source that is in the given range" do
    expect(almanac_map(79, maps)).to eq 81
  end

  it "returns the source for a source out of range" do
    expect(almanac_map(49, maps)).to eq 49
  end

  it "maps negative ranges" do
    expect(almanac_map(14, maps)).to eq 11
  end
end

describe "parse_maps" do
  let(:map_strings) do
    [
      "50 98 2",
      "52 50 48"
    ]
  end

  it "parses correctly" do
    expect(parse_maps(map_strings)).to eq({
      (98..99) => -48,
      (50..97) => 2
    })
  end
end
