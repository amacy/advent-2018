require_relative "../lib/day_07.rb"
require "pry"

RSpec.describe Day07 do
  context "part 1" do
    it "works for the sample input" do
      input = [
        "Step C must be finished before step A can begin.",
        "Step C must be finished before step F can begin.",
        "Step A must be finished before step B can begin.",
        "Step A must be finished before step D can begin.",
        "Step B must be finished before step E can begin.",
        "Step D must be finished before step E can begin.",
        "Step F must be finished before step E can begin.",
      ]
      expect(Day07.part_1(input)).to eq "CABDFE"
    end

    it "works for the sample input" do
      expect(Day07.part_1).to eq "MNQKRSFWGXPZJCOTVYEBLAHIUD"
    end
  end
end
