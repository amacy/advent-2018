require "set"

class Day10
  INPUT = File.readlines("config/day_10.txt")

  class Node
    attr_reader :horizontal_movement, :veritical_movement
    attr_accessor :row_number, :column_number

    def initialize(x, y, horizontal_movement, veritical_movement)
      @x = x
      @y = y
      @horizontal_movement = horizontal_movement
      @veritical_movement = veritical_movement
      @row_number = row_number
      @column_number = column_number
      @move = 0
    end

    def move_count
      @move
    end

    def move!(column_number, row_number)
      @move += 1
      @column_number = column_number
      @row_number = row_number
    end

    def row_value
      @y
    end

    def column_value
      @x
    end
  end

  def self.part_1(seconds, input=INPUT)
    nodes = []
    column_values = SortedSet.new
    row_values = SortedSet.new
    move_number = 0
    output = []

    input.each do |line|
      x, y, horizontal_movement, veritical_movement = line.scan(/\d+|-\d+/).map(&:to_i)
      column_values << x
      row_values << y
      nodes << Node.new(x, y, horizontal_movement, veritical_movement)
    end

    row_count = row_values.min.abs + row_values.max + 1
    column_count = column_values.min.abs + column_values.max + 1
    graph = _empty_graph(row_count, column_count)

    nodes.each do |node|
      row_number = row_values.min.abs + node.row_value
      column_number = column_values.min.abs + node.column_value

      node.row_number = row_number
      node.column_number = column_number
      graph[row_number][column_number] << node
    end

    output << _graph_string(graph)
    binding.pry

    seconds.times.map do |i|
      move_number += 1
      new_graph = _move_nodes(row_count, column_count, move_number, nodes)
      output << _graph_string(new_graph)
    end
		# output.each do |o|
		# 	puts o
    #   puts "\n"
		# end

    output
  end

  # this is too slow. turn the "graph" in to a hash?
  def self._graph_string(graph)
    graph.map do |row|
      if row.flatten.empty?
        "." * row.length
      else
        row.map do |nodes|
          if nodes.nil? || nodes.length > 0
            "#"
          else
            "."
          end
        end.join
      end
    end.join("\n")
  end

  def self._move_nodes(row_count, column_count, move_number, nodes)
    new_graph = _empty_graph(row_count, column_count)

    nodes.each do |node|
      column_number = _next_column_number(column_count, node)
      row_number = _next_row_number(row_count, node)
      node.move!(column_number, row_number)
      new_graph[row_number][column_number] << node
    end

    new_graph
  end

  def self._next_column_number(column_count, node)
    next_index = node.column_number + node.horizontal_movement
    if next_index > column_count - 1
      next_index - column_count - 1
    else
      next_index
    end
  end

  def self._next_row_number(row_count, node)
    next_index = node.row_number + node.veritical_movement
    if next_index > row_count - 1
      next_index - row_count - 1
    else
      next_index
    end
  end

  def self._empty_graph(row_count, column_count)
    row = Array.new(column_count, [])
    Array.new(row_count, row.dup)
  end
end
