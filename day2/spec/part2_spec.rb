require_relative('../part2.rb')

describe "max_by_keys" do
  context "with a single key" do
    let(:counts) do
      [
        { "green" => 2 },
        { "green" => 4 },
        { "green" => 1 }
      ]
    end

    it "finds the max value" do
      expect(max_by_keys(counts)).to eq({ "green" => 4 })
    end
  end

  context "with multiple keys" do
    let(:counts) do
      [
        { "green" => 2, "red" => 4 },
        { "green" => 4, "blue" => 5 },
        { "green" => 1, "red" => 2 }
      ]
    end

    it "finds the max values" do
      expect(max_by_keys(counts)).to eq({ "green" => 4, "red" => 4, "blue" => 5 })
    end
  end
end
