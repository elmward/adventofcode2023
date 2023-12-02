require_relative "../part2.rb"

describe "first_number" do
  it "identifies a digit" do
    expect(first_number("1")).to eq "1"
  end

  %w(one two three four five six seven eight nine).each.with_index do |word, i|
    it "identifies #{word}" do
      expect(first_number(word)).to eq (i + 1).to_s
    end
  end

  it "prefers the leftmost word" do
    expect(first_number("twone")).to eq "2"
  end

  it "finds the leftmost number even if internal" do
    expect(first_number("abcninedef1")).to eq "9"
  end
end

describe "right_number" do
  it "identifies a digit" do
    expect(right_number("1")).to eq "1"
  end

  %w(one two three four five six seven eight nine).each.with_index do |word, i|
    it "identifies #{word}" do
      expect(right_number(word)).to eq (i + 1).to_s
    end
  end

  it "prefers the rightmost word" do
    expect(right_number("twone")).to eq "1"
  end

  it "finds the rightmost number even if internal" do
    expect(right_number("abc1defninezxy")).to eq "9"
  end
end
