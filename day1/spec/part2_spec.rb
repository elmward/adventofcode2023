require_relative "../part2.rb"

describe "calibration_value" do
  it "handles digits" do
    expect(calibration_value("abc1jasgj5ajsdfj")).to eq 15
  end

  it "handles words" do
    expect(calibration_value("abcsninejaksdfjersevenjksdfj")).to eq 97
  end

  it "isn't fooled by overlaps" do
    expect(calibration_value("twone")).to eq 21
  end
end

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

describe "last_number" do
  it "identifies a digit" do
    expect(last_number("1")).to eq "1"
  end

  %w(one two three four five six seven eight nine).each.with_index do |word, i|
    it "identifies #{word}" do
      expect(last_number(word)).to eq (i + 1).to_s
    end
  end

  it "prefers the rightmost word" do
    expect(last_number("twone")).to eq "1"
  end

  it "finds the rightmost number even if internal" do
    expect(last_number("abc1defninezxy")).to eq "9"
  end
end
