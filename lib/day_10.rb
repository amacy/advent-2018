class Day10
  INPUT = File.readlines("config/day_10.txt")

  class Node
    attr_reader :x, :y
    attr_accessor :row_number, :column_number

    def initialize(x, y, x_velocity, y_velocity)
      @x = x
      @y = y
      @original_x = @x
      @original_y = @y
      @x_velocity = x_velocity
      @y_velocity = y_velocity
      @row_number = row_number
      @column_number = column_number
      @move = 0
    end

    def next_x
      @x + @x_velocity
    end

    def next_y
      @y + @y_velocity
    end

    def move!
      @x = next_x
      @y = next_x
      @move += 1
      self
    end

    def move_count
      @move
    end
  end

  def self.part_1(input=INPUT)
    nodes = []
    graph = []
    x_values = []
    y_values = []
    move_number = 0
    output = []

    input.each do |line|
      x, y, x_velocity, y_velocity = line.scan(/\d+|-\d+/).map(&:to_i)

      x_values << x
      y_values << y
      nodes << Node.new(x, y, x_velocity, y_velocity)
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

    3.times.map do |i|
      x_range = x_values.min..x_values.max
      y_range = y_values.min..y_values.max

      x_values = []
      y_values = []
      move_number += 1
      new_graph = _move_nodes(move_number, nodes, x_range, y_range, x_values, y_values)
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
		end

    output
  end

  def self._move_nodes(move_number, nodes, x_range, y_range, x_values, y_values)
    graph = []

    y_range.each_with_index do |y, row_number|
      graph[row_number] ||= []
      x_range.each_with_index do |x, column_number|
        graph[row_number][column_number] ||= []
        node = nodes.find { |node| node.next_x == x && node.next_y == y && node.move_count == move_number - 1 }
        if node
          x_values << x
          y_values << y
          node.row_number = row_number
          node.column_number = column_number
          graph[row_number][column_number] << node.move!
        end
      end
    end

    graph
  end
end
