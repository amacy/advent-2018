require_relative "../lib/day_01.rb"
require "pry"

RSpec.describe Day01 do
  context "part 1" do
    it "calculates the resulting frequency using sample input resulting in a positive total" do
      input = [1, 1, 1]
      expect(Day01.resulting_frequency(input)).to eq 3
    end

    it "calculates the resulting frequency using sample input resulting in a negative total" do
      input = [-1, -2, -3]
      expect(Day01.resulting_frequency(input)).to eq -6
    end

    it "calculates the resulting frequency using sample input resulting in a 0 total" do
      input = [1, 1, -2]
      expect(Day01.resulting_frequency(input)).to eq 0
    end

    it "calculates the resulting frequency using input file" do
      expect(Day01.resulting_frequency).to eq 406
    end
  end

  context "part 2" do
    it "returns the first frequency received twice if it's 0" do
      input_1 = [1, -1]
      expect(Day01.first_frequency_reached_twice(input_1)).to eq 0

      input_2 = [3, 3, 4, -2, -4]
      expect(Day01.first_frequency_reached_twice(input_2)).to eq 10

      input_3 = [-6, 3, 8, 5, -6]
      expect(Day01.first_frequency_reached_twice(input_3)).to eq 5

      input_4 = [7, 7, -2, -7, -4]
      expect(Day01.first_frequency_reached_twice(input_4)).to eq 14
    end

    it "calculates the first frequency using input file" do
      expect(Day01.first_frequency_reached_twice).to eq 312
    end
  end
end
