require_relative "../part1.rb"

describe "parse_card" do
  it "produces winning numbers and my numbers" do
    expect(parse_card("Card 130: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")).to eq [[41, 48, 83, 86, 17], [83, 86, 6, 31, 17, 9, 48, 53]]
  end

  it "parses the format with extra spaces" do
    expect(parse_card("Card 21:  1  4  3 34 | 43 23  1")).to eq [[1, 4, 3, 34], [43, 23, 1]]
  end
end

describe "score" do
  it "is 0 for no matching numbers" do
    expect(score([1, 5], [3, 2, 10, 7])).to eq 0
  end

  it "is 1 for one matching number" do
    expect(score([1, 5], [3, 2, 1, 7])).to eq 1
  end

  it "is 2 for two matching numbers" do
    expect(score([1, 5], [3, 2, 1, 7, 5])).to eq 2
  end

  it "is 4 for three matching numbers" do
    expect(score([1, 5, 0, 12], [3, 2, 1, 12, 7, 5])).to eq 4
  end

  it "is 16 for five matching numbers" do
    expect(score([1, 5, 0, 12, 32, 8], [3, 2, 32, 1, 12, 8, 7, 5])).to eq 16
  end
end
