require_relative "../lib/day_01.rb"
require "pry"

RSpec.describe Day01 do
  it "calculates the resulting frequency using sample input resulting in a positive total" do
    input = [1, 1, 1]
    expect(Day01.process(input)).to eq 3
  end

  it "calculates the resulting frequency using sample input resulting in a negative total" do
    input = [-1, -2, -3]
    expect(Day01.process(input)).to eq -6
  end

  it "calculates the resulting frequency using sample input resulting in a 0 total" do
    input = [1, 1, -2]
    expect(Day01.process(input)).to eq 0
  end

  it "calculates the resulting frequency using input file" do
    expect(Day01.process).to eq 406
  end
end
