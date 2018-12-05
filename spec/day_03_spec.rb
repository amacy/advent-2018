require_relative "../lib/day_03.rb"
require "pry"

RSpec.describe Day03 do
  context "part 1" do
    it "finds the overlapping areas in the sample input" do
      input = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "##3 @ 5,5: 2x2"]
      expect(Day03.overlapping_area(input)).to eq 4
    end

    it "finds the overlapping areas in the input file" do
      expect(Day03.overlapping_area).to eq 103806
    end
  end

  context "part 2" do
    it "finds the non-overlapping claims in the sample input" do
      input = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "##3 @ 5,5: 2x2"]
      expect(Day03.non_overlapping_claim(input)).to eq 3
    end

    it "finds the overlapping areas in the input file" do
      expect(Day03.non_overlapping_claim).to eq 625
    end
  end
end
