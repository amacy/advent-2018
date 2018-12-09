class Day08
  INPUT = File.readlines("config/day_08.txt").first.split(/ /).map(&:to_i)

  class Node
    attr_reader :expected_children_count, :metadata_entry_count, :parent, :metadata, :children

    def initialize(expected_children_count, metadata_entry_count, parent)
      @expected_children_count = expected_children_count
      @metadata_entry_count = metadata_entry_count
      @parent = parent
      @metadata = []
      @children = []
    end

    def add_metadata(metadata)
      @metadata << metadata
    end

    def metadata_total
      @metadata.inject(&:+) || 0
    end

    def add_child(child)
      raise "parent received unexpected child" if @children.length == @expected_children_count
      @children << child
    end

    def metadata_populated?
      @metadata.length == @metadata_entry_count
    end

    def children_populated?
      @children.length == @expected_children_count
    end
  end

  def self.part_1(input=INPUT)
    nodes = _generate_tree(input)

    nodes.inject(0) do |sum, node|
      sum += node.metadata_total
    end
  end

  def self._generate_tree(input)
    remaining_input = input.dup

    root = _create_node(remaining_input, nil)
    root.metadata_entry_count.times do
      metadata = remaining_input.pop
      root.add_metadata(metadata)
    end
    nodes = [root]
    child = nil
    parent = root

    loop do
      break if remaining_input.empty?
      child = _create_node(remaining_input, parent)
      parent.add_child(child)
      nodes << child

      if child.children_populated?
        parent = _populate_metadata_up_the_tree(remaining_input, child)
        if parent.children_populated?
          # this doesn't work
          parent = nodes.find { |node| !node.children_populated? }
        end
      else
        parent = child
      end
    end

    nodes
  end

  def self._create_node(remaining_input, parent)
    Node.new(remaining_input.shift, remaining_input.shift, parent)
  end

  def self._populate_metadata_up_the_tree(remaining_input, node)
    candidate = node
    loop do
      break candidate if candidate.metadata_populated?

      candidate.metadata_entry_count.times do
        metadata = remaining_input.shift
        candidate.add_metadata(metadata)
      end

      candidate = candidate.parent
    end
  end
end
