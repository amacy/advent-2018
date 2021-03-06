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
      @children << child
    end

    def metadata_populated?
      @metadata.length == @metadata_entry_count
    end

    def children_populated?
      @children.length == @expected_children_count
    end

    def value
      if @expected_children_count > 0
        metadata.inject(0) do |sum, index|
          child = @children[index - 1]

          if child.nil?
            sum
          else
            sum += child.value
          end
        end
      else
        metadata_total
      end
    end
  end

  def self.part_1(input=INPUT)
    nodes = _generate_tree(input)

    nodes.inject(0) do |sum, node|
      sum += node.metadata_total
    end
  end

  def self.part_2(input=INPUT)
    nodes = _generate_tree(input)

    nodes.first.value
  end

  def self._generate_tree(input)
    remaining_input = input.dup

    root = _create_node(remaining_input, nil)
    nodes = [root]
    queue = [root]

    loop do
      break if remaining_input.empty?

      node = queue.shift
      if node.children_populated?
        node.metadata_entry_count.times do
          node.add_metadata(remaining_input.shift)
        end
      else
        child = _create_node(remaining_input, node)
        node.add_child(child)
        nodes << child
        queue.unshift(node)
        queue.unshift(child)
      end
    end

    nodes
  end

  def self._create_node(remaining_input, parent)
    Node.new(remaining_input.shift, remaining_input.shift, parent)
  end
end
