require_relative "../lib/day_06.rb"
require "pry"

RSpec.describe Day06 do
  context "part 1" do
    it "works for the sample input" do
      input = [
        [1, 1],
        [1, 6],
        [8, 3],
        [3, 4],
        [5, 5],
        [8, 9],
      ]
      expect(Day06.part_1(input)).to eq 17
    end

    it "works for the sample input" do
      expect(Day06.part_1).to eq 4342
    end
  end
end
