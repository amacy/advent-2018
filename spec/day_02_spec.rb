require_relative "../lib/day_02.rb"
require "pry"

RSpec.describe Day02 do
  context "part 1" do
    it "calculates the correct answer for the sample input" do
      ids = %w(abcdef bababc abbcde abcccd aabcdd abcdee ababab)
      expect(Day02.checksum(ids)).to eq 12
    end

    it "calculates the correct answer for the input file" do
      expect(Day02.checksum).to eq 7410
    end
  end

  context "part 2" do
    it "finds the ids that have only 1 letter difference for the sample input" do
      ids = %w(abcde fghij klmno pqrst fguij axcye wvxyz)
      expect(Day02.common_letters(ids)).to eq "fgij"
    end

    it "finds the ids that have only 1 letter difference for the input file" do
      expect(Day02.common_letters).to eq "cnjxoritzhvbosyewrmqhgkul"
    end
  end
end
