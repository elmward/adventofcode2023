require_relative "../part2.rb"

describe "map_sources" do
  let(:maps) do
    {
      (50..98) => 2,
      (12..24) => -3
    }
  end

  it "maps a source range that is in the given range" do
    expect(map_sources([70..72], maps)).to match_array([50..69, 72..74, 73..98])
  end

  it "returns the source range for a source out of range" do
    expect(map_sources([48..49], maps)).to eq [48..49]
  end

  it "maps negative ranges" do
    expect(map_sources([14..18], maps)).to eq [11..15]
  end

  it "maps ranges that partially match but extend beyond the source range" do
    expect(map_sources([97..101], maps)). to match_array [99..100, 99..101]
  end

  it "maps ranges that partially match but extend before the source range" do
    expect(map_sources([48..52], maps)).to match_array [48..49, 52..54]
  end
end
