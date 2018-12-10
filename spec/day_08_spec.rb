require_relative "../lib/day_08.rb"
require "pry"

RSpec.describe Day08 do
  context "part 1" do
    context "sample input" do
      it "returns the correct answer" do
        input = [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]
        expect(Day08.part_1(input)).to eq 138
      end

      it "generates the expected tree" do
        input = [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]
        nodes = Day08._generate_tree(input)
        # A
        expect(nodes[0].expected_children_count).to eq 2
        expect(nodes[0].metadata_entry_count).to eq 3
        expect(nodes[0].parent).to eq nil
        expect(nodes[0].children.length).to eq 2
        expect(nodes[0].metadata).to eq [1, 1, 2]
        # B
        expect(nodes[1].expected_children_count).to eq 0
        expect(nodes[1].metadata_entry_count).to eq 3
        expect(nodes[1].parent).to eq nodes[0]
        expect(nodes[1].children.length).to eq 0
        expect(nodes[1].metadata).to eq [10, 11, 12]
        # C
        expect(nodes[2].expected_children_count).to eq 1
        expect(nodes[2].metadata_entry_count).to eq 1
        expect(nodes[2].parent).to eq nodes[0]
        expect(nodes[2].children.length).to eq 1
        expect(nodes[2].metadata).to eq [2]
        # D
        expect(nodes[3].expected_children_count).to eq 0
        expect(nodes[3].metadata_entry_count).to eq 1
        expect(nodes[3].parent).to eq nodes[2]
        expect(nodes[3].children.length).to eq 0
        expect(nodes[3].metadata).to eq [99]
      end
    end

    context "a more complicated take on the sample input" do
      it "works for some input i made up" do
        input = [2, 3, 0, 3, 10, 11, 12, 2, 1, 0, 1, 99, 0, 1, 73, 2, 1, 1, 2]
        expect(Day08.part_1(input)).to eq 138 + 73
      end

      it "generates the expected tree" do
        input = [2, 3, 0, 3, 10, 11, 12, 2, 1, 0, 1, 99, 0, 1, 73, 2, 1, 1, 2]
        nodes = Day08._generate_tree(input)
        # A
        expect(nodes[0].expected_children_count).to eq 2
        expect(nodes[0].metadata_entry_count).to eq 3
        expect(nodes[0].parent).to eq nil
        expect(nodes[0].children.length).to eq 2
        expect(nodes[0].metadata).to eq [1, 1, 2]
        # B
        expect(nodes[1].expected_children_count).to eq 0
        expect(nodes[1].metadata_entry_count).to eq 3
        expect(nodes[1].parent).to eq nodes[0]
        expect(nodes[1].children.length).to eq 0
        expect(nodes[1].metadata).to eq [10, 11, 12]
        # C
        expect(nodes[2].expected_children_count).to eq 2
        expect(nodes[2].metadata_entry_count).to eq 1
        expect(nodes[2].parent).to eq nodes[0]
        expect(nodes[2].children.length).to eq 2
        expect(nodes[2].metadata).to eq [2]
        # D
        expect(nodes[3].expected_children_count).to eq 0
        expect(nodes[3].metadata_entry_count).to eq 1
        expect(nodes[3].parent).to eq nodes[2]
        expect(nodes[3].children.length).to eq 0
        expect(nodes[3].metadata).to eq [99]
        # E
        expect(nodes[4].expected_children_count).to eq 0
        expect(nodes[4].metadata_entry_count).to eq 1
        expect(nodes[4].parent).to eq nodes[2]
        expect(nodes[4].children.length).to eq 0
        expect(nodes[4].metadata).to eq [73]
      end
    end

    it "works for the input file" do
      expect(Day08.part_1).to eq 40746
    end
  end

  context "part 2" do
    it "returns the correct answer" do
      input = [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]
      expect(Day08.part_2(input)).to eq 66
    end

    it "works for the input file" do
      expect(Day08.part_2).to eq 37453
    end
  end
end
