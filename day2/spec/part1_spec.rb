require_relative('../part1.rb')

describe "count_cubes" do
  it "counts a single color" do
    expect(count_cubes("3 green")).to eq({"green" => 3})
  end

  it "counts multiple colors" do
    expect(count_cubes("1 red, 2 green, 6 blue")).to eq(
      {
        "red" => 1,
        "green" => 2,
        "blue" => 6,
      }
    )
  end

  it "works for un-pulled colors" do
    expect(count_cubes("3 green")["red"]).to eq 0
  end
end
