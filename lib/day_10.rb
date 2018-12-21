class Day10
  INPUT = File.readlines("config/day_10.txt")

  class Node
    attr_reader :x, :y, :horizontal_movement, :veritical_movement
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
  end

  def self.part_1(seconds, input=INPUT)
    nodes = []
    graph = []
    x_values = []
    y_values = []
    move_number = 0
    output = []

    input.each do |line|
      x, y, horizontal_movement, veritical_movement = line.scan(/\d+|-\d+/).map(&:to_i)

      x_values << x
      y_values << y
      nodes << Node.new(x, y, horizontal_movement, veritical_movement)
    end

    x_range = x_values.min..x_values.max
    y_range = y_values.min..y_values.max

    x_values = []
    y_values = []
    y_range.each_with_index do |y, row_number|
      graph[row_number] ||= []
      x_range.each_with_index do |x, column_number|
        graph[row_number][column_number] ||= []
        node = nodes.find { |node| node.x == x && node.y == y }
        if node
          x_values << x
          y_values << y
          node.row_number = row_number
          node.column_number = column_number
          graph[row_number][column_number] << node
        end
      end
    end

    string = graph.map do |row|
      row.map do |nodes|
        if nodes.length > 0
          "#"
        else
          "."
        end
      end.join
    end.join("\n")
    output << string

    seconds.times.map do |i|
      move_number += 1
      new_graph = _move_nodes(graph, move_number, nodes)
      string = new_graph.map do |row|
        row.map do |nodes|
          if nodes.length > 0
            "#"
          else
            "."
          end
        end.join
      end.join("\n")
      output << string
    end
		output.each do |o|
			puts o
      puts "\n"
		end

    output
  end

  def self._move_nodes(graph, move_number, nodes)
    new_graph = graph.dup

    graph.each_with_index do |row, row_number|
      row.each_with_index do |_, column_number|
        new_graph[row_number][column_number] = []
        nodes_to_move = nodes.select do |node|
          _next_column_number(graph, node, column_number) == column_number &&
            _next_row_number(graph, node, row_number) == row_number &&
            node.move_count == move_number - 1
        end
        if nodes_to_move.length > 0
          nodes_to_move.each do |node|
            node.move!(column_number, row_number)
            new_graph[row_number][column_number] << node
          end
        end
      end
    end

    new_graph
  end

  def self._next_column_number(graph, node, column_number)
    next_index = node.column_number + node.horizontal_movement
    if next_index > graph.first.length - 1
      next_index - graph.first.length - 1
    else
      next_index
    end
  end

  def self._next_row_number(graph, node, row_number)
    next_index = node.row_number + node.veritical_movement
    if next_index > graph.length - 1
      next_index - graph.length - 1
    else
      next_index
    end
  end
end
