require_relative "../lib/day_05.rb"
require "pry"

RSpec.describe Day05 do
  context "part 1" do
    it "works for the sample input" do
      input = "dabAcCaCBAcCcaDA".split(//)
      expect(Day05.part_1(input)).to eq 10
    end

    it "works for the input file" do
      expect(Day05.part_1).to eq 11754
    end
  end
end
