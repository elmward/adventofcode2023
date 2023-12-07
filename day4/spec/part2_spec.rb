require_relative "../part2.rb"

describe "parse_cards" do
  let(:input) do
    [
      "Card   1: 12 94 13 |  1 94  4 13  2",
      "Card   2:  2 27 15 |  4  9  2 13 27"
    ].join("\n")
  end

  it "produces a hash keyed by card numbers" do
    expect(parse_cards(input)).to eq (
      {
        1 => [[12, 94, 13], [1, 94, 4, 13, 2]],
        2 => [[2, 27, 15], [4, 9, 2, 13, 27]]
      }
    )
  end
end

describe "card_counts" do
  let(:cards) do
    {
      1 => [[12, 94, 13], [1, 94, 4, 3, 2]], # one winner
      2 => [[2, 27, 15], [4, 9, 2, 13, 27]], # two winners
      3 => [[3, 5, 7], [1, 4, 6, 8]], # no winners
      4 => [[4, 6, 8], [1, 4, 5, 7]] # one winner
    }
  end

  it "counts up the number of each card" do
    expect(card_counts(cards)).to eq(
      {
        1 => 1,
        2 => 2,
        3 => 2,
        4 => 2
      }
    )
  end
end

describe "num_winners" do
  it "counts the number of winners on a card" do
    expect(num_winners([2, 27, 15], [4, 9, 2, 13, 27])).to eq 2
  end
end
