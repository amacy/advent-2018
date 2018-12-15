require_relative "../lib/day_14.rb"
require "pry"

RSpec.describe Day14 do
  context "part 1" do
    it "returns the correct answer for the sample input" do
      expect(Day14.part_1(5)).to eq "0124515891"
      expect(Day14.part_1(9)).to eq "5158916779"
      expect(Day14.part_1(18)).to eq "9251071085"
      expect(Day14.part_1(2018)).to eq "5941429882"
    end

    it "returns the correct answer for the puzzle input" do
      expect(Day14.part_1(380621)).to eq "6985103122"
    end
  end

  context "part 2" do
    it "returns the correct answer for the sample input" do
      expect(Day14.part_2("01245")).to eq 5
      expect(Day14.part_2("51589")).to eq 9
      expect(Day14.part_2("92510")).to eq 18
      expect(Day14.part_2("59414")).to eq 2018
    end

    it "returns the correct answer for the puzzle input" do
      expect(Day14.part_2("380621")).to eq 6985103122
    end
  end
end
