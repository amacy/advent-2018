require_relative "../lib/day_11.rb"
require "pry"

RSpec.describe Day11 do
  context "FuelCell" do
    it "calculates the correct power level for sample input" do
      expect(Day11::FuelCell.new(122, 79).power_level(57)).to eq -5
      expect(Day11::FuelCell.new(217, 196).power_level(39)).to eq 0
      expect(Day11::FuelCell.new(101, 153).power_level(71)).to eq 4
    end
  end

  context "part 1" do
    it "returns the correct answer for the sample input" do
      expect(Day11.part_1(18)).to eq "33,45"
      expect(Day11.part_1(42)).to eq "21,61"
    end

    it "returns the correct answer for the puzzle input" do
      expect(Day11.part_1(7689)).to eq "20,37"
    end
  end

  context "part 2" do
    it "returns the correct answer for the sample input" do
      expect(Day11.part_2(18)).to eq "90,269,16"
      expect(Day11.part_2(42)).to eq "232,251,12"
    end

    xit "returns the correct answer for the puzzle input" do
      expect(Day11.part_2(7689)).to eq "20,37"
    end
  end
end
