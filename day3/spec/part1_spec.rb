require_relative '../part1.rb'

describe "parse_diagram" do
  let(:diagram_input) do
    [
      "56*...",
      "....&.",
      "..#...",
      "...45."
    ].join("\n")
  end

  it "properly parses the diagram" do
    puts diagram_input.split("\n").inspect
    expect(parse_diagram(diagram_input)).to eq({
      numbers: {
        [0,0] => 56,
        [3,3] => 45,
      },
      symbols: {
        [0,2] => '*',
        [1,4] => '&',
        [2,2] => '#',
      }
    })
  end
end

describe "adjacent?" do
  it "is true for an item to the left" do
    expect(adjacent?([0,1], [0,0], 1)).to eq true
  end

  it "is true for an item within the string's length to the right" do
    expect(adjacent?([0,3], [0,0], 3)).to eq true
  end

  it "is false for an item 2 to the left" do
    expect(adjacent?([0,0], [0,2], 2)).to eq false
  end

  it "is false for an item more than the string's length to the right" do
    expect(adjacent?([0,3], [0,0], 2)).to eq false
  end

  it "is true for an item above and to the left" do
    expect(adjacent?([0,0], [1,1], 1)).to eq true
  end

  it "is true for an item below and to the left" do
    expect(adjacent?([1,0], [0,1], 1)).to eq true
  end

  it "is true for an item above and within the string's length to the right" do
    expect(adjacent?([0,3], [1,0], 3)).to eq true
  end

  it "is true for an item below and within the string's length to the right" do
    expect(adjacent?([1,3], [0,0], 3)).to eq true
  end

  it "is false for an item above and 2 to the left" do
    expect(adjacent?([0,0], [1,2], 2)).to eq false
  end

  it "is false for an item above and more than the string's length to the right" do
    expect(adjacent?([0,3], [1,0], 2)).to eq false
  end

  it "is false for an item below and 2 to the left" do
    expect(adjacent?([1,0], [0,2], 2)).to eq false
  end

  it "is false for an item below and more than the string's length to the right" do
    expect(adjacent?([1,3], [0,0], 2)).to eq false
  end
end
describe "part_number?" do
  context "when there is a symbol to the right" do
    let(:diagram) do
      {
        numbers:
        {
          [0,0] => 467,
        },
        symbols:
        {
          [0,3] => '*',
        }
      }
    end

    it "is true" do
      expect(part_number?([0,0], diagram)).to eq true
    end
  end

  context "when there is a symbol to the left" do
    let(:diagram) do
      {
        numbers:
        {
          [2,1] => 51,
        },
        symbols:
        {
          [2,0] => '&',
        }
      }
    end

    it "is true" do
      expect(part_number?([2,1], diagram)).to eq true
    end
  end

  context "when there is a diagonally adjacent symbol" do
    let(:diagram) do
      {
        numbers:
        {
          [0,0] => 467,
          [3,1] => 51,
          [7,0] => 98,
          [10, 1] => 1,
        },
        symbols:
        {
          [1,3] => '*',
          [4,0] => '&',
          [6,2] => '%',
          [9,0] => '$',
        }
      }
    end

    it "is true" do
      diagram[:numbers].each do |position, _|
        expect(part_number?(position, diagram)).to eq true
      end
    end
  end
end
