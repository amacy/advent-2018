require_relative "../lib/day_09.rb"
require "pry"

RSpec.describe Day09 do
  context "part 1" do
    it "returns the correct answer for the sample input" do
      expect(Day09.part_1(9, 25)).to eq 32
      expect(Day09.part_1(10, 1618)).to eq 8317
      expect(Day09.part_1(13, 7999)).to eq 146373
      expect(Day09.part_1(17, 1104)).to eq 2764
      expect(Day09.part_1(21, 6111)).to eq 54718
      expect(Day09.part_1(30, 5807)).to eq 37305
    end

    it "returns the correct answer for the sample file" do
      expect(Day09.part_1(446, 71522)).to eq 390592
    end
  end
end
